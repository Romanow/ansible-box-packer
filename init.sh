#!/usr/bin/env bash

sudo -u ansible mkdir -p /home/ansible/.ssh
sudo usermod --shell /bin/bash ansible

sudo apt-get update --yes
pip3 install --upgrade pip