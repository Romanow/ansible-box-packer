packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
    digitalocean = {
      version = ">= 1.0.4"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

variable "vagrant_token" {
  type        = string
  description = "Token for publishing to Vagrant Cloud"
  sensitive   = true
}

variable "do_token" {
  type        = string
  description = "DigitalOcean access token"
  sensitive   = true
}

variable "do_spaces_key" {
  type        = string
  description = "DigitalOcean spaces key"
  sensitive   = true
}

variable "do_spaces_secret" {
  type        = string
  description = "DigitalOcean spaces secret"
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "SSH user"
  default     = "ansible"
}

variable "ssh_password" {
  type        = string
  description = "SSH password"
  default     = "root"
}

source "virtualbox-iso" "vb" {
  disk_size            = 20000
  memory               = 4096
  cpus                 = 2
  guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type        = "Ubuntu_64"
  headless             = true

  boot_wait      = "10s"
  http_directory = "http"
  boot_command   = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]

  iso_checksum = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  iso_url      = "https://releases.ubuntu.com/22.04/ubuntu-22.04.1-live-server-amd64.iso"

  communicator     = "ssh"
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  ssh_wait_timeout = "10000s"
  shutdown_command = "echo '${var.ssh_username}' | sudo -S shutdown -P now"

  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", 4096],
    ["modifyvm", "{{ .Name }}", "--cpus", 2]
  ]
  vm_name         = "ubuntu-22.04"
  output_filename = "ansible-box-ubuntu-2204.box"
}

build {
  sources = ["source.virtualbox-iso.vb"]

  provisioner "shell" {
    script = "init.sh"
  }

  post-processors {
    post-processor "digitalocean-import" {
      api_token           = var.do_token
      spaces_key          = var.do_spaces_key
      spaces_secret       = var.do_spaces_secret
      spaces_region       = "ams3"
      space_name          = "import-bucket"
      image_name          = "ansible-box-ubuntu-2204.box"
      image_description   = "Custom Ubuntu 22.04 image"
      image_regions       = ["ams3"]
      image_tags          = ["packer"]
      keep_input_artifact = true
    }
    post-processor "vagrant" {
      output              = "builds/{{ .Provider }}-ansible-box-ubuntu2204.box"
      keep_input_artifact = true
    }
    post-processor "vagrant-cloud" {
      access_token        = var.vagrant_token
      box_tag             = "romanow/ansible-box"
      version             = "22.04"
      keep_input_artifact = true
    }
  }
}