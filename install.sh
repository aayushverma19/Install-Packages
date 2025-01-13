#!/bin/bash

# Variables
MASTER="ubuntu@<master_ip>"
BASTION="ubuntu@13.201.0.115"
PEM_FILE="mysql.pem"

# Step 1: Execute on Master
echo "Step 1: Copying PEM file to Bastion Host from Master..."
scp -o StrictHostKeyChecking=no -i "$PEM_FILE" "$PEM_FILE" "$BASTION:/home/ubuntu/"

echo "Connecting to Bastion Host from Master..."
ssh -o StrictHostKeyChecking=no -i "$PEM_FILE" "$BASTION" << EOF
    echo "Connected to Bastion Host"
    
    # Step 2: Clone Git Repository and Install Required Packages
    echo "Cloning Git repository..."
    git clone https://github.com/aayushverma191/mysqlpvtinstance.git

    echo "Installing required packages..."
    sudo apt update && sudo apt install ansible python3-pip python3-boto3 -y

    echo "Installing Ansible Galaxy Collection..."
    ansible-galaxy collection install community.mysql

    # Step 3: Execute Ansible Playbook
    echo "Running Ansible Playbook..."
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /home/ubuntu/mysqlpvtinstance/assignment5/toolbook.yml --private-key /home/ubuntu/mysql.pem

    echo "Setup and Playbook execution complete on Bastion Host!"
EOF

