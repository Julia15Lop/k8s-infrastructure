#!/bin/bash

set -xe

# Update system
sudo yum update -y

# Install Chrony 
sudo yum install chrony -y
sudo systemctl enable chronyd

# Create user
sudo adduser -md /home/ansible ansible
echo "ansible" | sudo passwd ansible --stdin

# Generate keys
FILE=~/.ssh/id_rsa
PUB_KEY=~/.ssh/id_rsa.pub

# Create local ssh keys
if [[ ! -f "$FILE" ]]; then
    echo "$FILE does not exist."
    echo -e "\n\n\n" | ssh-keygen -t rsa -b 4096
fi

# Authorize SSH public key into ansible
sudo cat /root/.ssh/id_rsa.pub | tee /home/ansible/.ssh/authorized_keys
sudo cp /root/.ssh/id_rsa /home/ansible/id_rsa
sudo cp /root/.ssh/id_rsa.pub /home/ansible/id_rsa.pub
sudo chown -R ansible:ansible /home/ansible/.ssh/

# Install python ansible git
sudo yum install python3 git ansible -y
