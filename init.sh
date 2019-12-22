#!/bin/bash
sudo su -

apt-get install virtualbox-guest-utils --no-install-recommends --yes

useradd -m --p $(echo root | openssl passwd -1 -stdin) ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
sudo -u ansible mkdir /home/ansible/.ssh
usermod --shell /bin/bash ansible

apt-get update --yes
apt install software-properties-common python3-pip --yes
pip3 install --upgrade pip

sed -i 's/PasswordAuthentication no*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd