#!/bin/bash
set -xe

# Update system
sudo yum update -y

# Set hostname
HOST_PREFIX=nfs
sudo hostnamectl set-hostname $HOST_PREFIX.azure

hostname | tee /etc/hostname

# Set timezone
sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true

# Disable SELinux
sed -i s/=enforcing/=disabled/g /etc/selinux/config

# Reboot system
sudo reboot