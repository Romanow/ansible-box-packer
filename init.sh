#!/bin/bash

sudo apt-get install virtualbox-guest-utils --no-install-recommends --yes

sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
sudo -u ansible mkdir -p /home/ansible/.ssh
sudo usermod --shell /bin/bash ansible

sudo apt-get update --yes
sudo apt install software-properties-common python3-pip --yes
sudo pip3 install --upgrade pip

sudo sed -i 's/PasswordAuthentication no*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd