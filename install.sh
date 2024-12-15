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


##aws
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install 

##terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y


##java
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)

#jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y 
