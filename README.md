# Vagrant box

[![Build project](https://github.com/Romanow/ansible-box-packer/actions/workflows/build.yml/badge.svg)](https://github.com/Romanow/ansible-box-packer/actions/workflows/build.yml)

Создание образа Ubuntu 22.04 LTS для `Virtualbox`:

* с пользователем `ansible`/`root` без запроса пароля для sudo;
* предустановленными пакетами:
    *

## Сборка

Получить токен [Vagrant Cloud](https://app.vagrantup.com/) -> `Profile` -> `Security`.

```shell
$ echo 'cloud_token = "<vagrant cloud token>"' > vars.pkrvars.hcl

$ packer build -var-file=vars.pkrvars.hcl template.pkr.hcl
```

Собранный образ находится в папке `builds/`, и опубликуется в
репозиторий [ansible-box](https://app.vagrantup.com/romanow/boxes/ansible-box).

## Проверка

Для проверки можно запустить [vagrant](vagrant/Vagrantfile):

```shell
$ vagrant up

Bringing machine 'virtualbox' up with 'virtualbox' provider...
==> virtualbox: Box 'file://../builds/ansible-box-ubuntu-2204.box' could not be found. Attempting to find and install...
    virtualbox: Box Provider: virtualbox
    virtualbox: Box Version: >= 0
==> virtualbox: Box file was not detected as metadata. Adding it directly...
==> virtualbox: Adding box 'file://../builds/ansible-box-ubuntu-2204.box' (v0) for provider: virtualbox
    virtualbox: Unpacking necessary files from: file:///Users/aromanov/Develop/packer/ansible-box-packer/builds/ansible-box-ubuntu-2204.box
==> virtualbox: Successfully added box 'file://../builds/ansible-box-ubuntu-2204.box' (v0) for 'virtualbox'!
==> virtualbox: Importing base box 'file://../builds/ansible-box-ubuntu-2204.box'...
==> virtualbox: Matching MAC address for NAT networking...
==> virtualbox: Setting the name of the VM: vagrant_virtualbox_1667651821168_95104
==> virtualbox: Clearing any previously set network interfaces...
==> virtualbox: Preparing network interfaces based on configuration...
    virtualbox: Adapter 1: nat
    virtualbox: Adapter 2: hostonly
==> virtualbox: Forwarding ports...
    virtualbox: 22 (guest) => 2222 (host) (adapter 1)
==> virtualbox: Running 'pre-boot' VM customizations...
==> virtualbox: Booting VM...
==> virtualbox: Waiting for machine to boot. This may take a few minutes...
    virtualbox: SSH address: 127.0.0.1:2222
    virtualbox: SSH username: ansible
    virtualbox: SSH auth method: password
    virtualbox:
    virtualbox: Inserting generated public key within guest...
    virtualbox: Removing insecure key from the guest if it's present...
    virtualbox: Key inserted! Disconnecting and reconnecting using new SSH key...
==> virtualbox: Machine booted and ready!
==> virtualbox: Checking for guest additions in VM...
==> virtualbox: Setting hostname...
==> virtualbox: Configuring and enabling network interfaces...
==> virtualbox: Mounting shared folders...
    virtualbox: /vagrant => /Users/aromanov/Develop/packer/ansible-box-packer/vagrant
==> virtualbox: Running provisioner: shell...
    virtualbox: Running: inline script
    virtualbox: Hello, World
```