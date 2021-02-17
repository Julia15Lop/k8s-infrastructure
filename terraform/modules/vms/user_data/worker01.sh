#!/bin/bash
set -xe

# Set hostname
HOST_PREFIX=worker01
sudo hostnamectl set-hostname $HOST_PREFIX.azure

sudo hostname | tee /etc/hostname

# Set timezone
sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true

# Disable SELinux
sudo sed -i s/=enforcing/=disabled/g /etc/selinux/config
