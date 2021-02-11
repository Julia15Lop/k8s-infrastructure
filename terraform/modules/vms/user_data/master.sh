# Install and enable chrony
dnf install chrony -y
systemctl enbale chronyd
dnf update -y

# Add user
adduser –md /home/ansible ansible
passwd ansible

# Install python3 -y
dnf install python3 -y

# Install Git and Ansible
dnf install git ansible -y

# Clone Repo
git clone 

# Reboot system
reboot