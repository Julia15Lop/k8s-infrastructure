# Install and enable chrony
dnf install chrony -y
systemctl enbale chronyd
dnf update -y

# Add user
adduser –md /home/ansible ansible
passwd ansible

reboot