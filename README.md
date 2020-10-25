# Vagrant box

Based on Ubuntu Server 20.04 LTS create `Virtualbox` image with user `ansible`/`root`
with sudo rights without password request for operations.

### Build
```shell script
packer build -var-file vagrant-props.json -var-file vagrant-cloud.json template.json
```
The assembly will be located in `builds/` directory `virtualbox-ansible-box-ubuntu2004.box`.

### Publish
1. Get token from [Vagrant Cloud](https://app.vagrantup.com/) -> Profile -> Security.
1. Create file `vagrant-cloud.json` based on `vagrant-file.example.json` with token.
1. Run build, new release will create in Post-Processors.