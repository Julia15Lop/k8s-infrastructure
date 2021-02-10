#!/bin/bash

FILE=/home/julia/.ssh/id_rsa
PUB_KEY=/home/julia/.ssh/id_rsa.pub

# Create local ssh keys
if [[ ! -f "$FILE" ]]; then
    echo "$FILE does not exist."
    echo -e "\n\n\n" | ssh-keygen -t rsa -b 4096
fi

# Copy pub key into node
ssh-copy-id -i $FILE ansible@master