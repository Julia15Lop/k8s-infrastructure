#!/bin/bash
set -xe

# Update system
sudo yum update -y

# Set hostname
HOST_PREFIX=master-nfs
sudo hostnamectl set-hostname $HOST_PREFIX.azure

sudo hostname | tee /etc/hostname

# Set timezone
sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true

# Disable SELinux
sed -i s/=enforcing/=disabled/g /etc/selinux/config

# Install Ansible
sudo yum install epel-release -y
sudo yum install ansible -y

# Reboot system
sudo reboot