# Vagrant box

Based on Ubuntu Server 22.04 LTS create `Virtualbox` image with user `ansible`/`root`
with sudo rights without password request for operations.

### Сборка

```shell script
packer build -var-file props.json -var-file variables.pkr.hcl template.json
```

The assembly will be located in `builds/` directory `virtualbox-ansible-box-ubuntu2204.box`.

### Publish

1. Get token from [Vagrant Cloud](https://app.vagrantup.com/) -> Profile -> Security.
1. Create file `vagrant-cloud.json` based on `vagrant-file.example.json` with token.
1. Run build, new release will create in Post-Processors.