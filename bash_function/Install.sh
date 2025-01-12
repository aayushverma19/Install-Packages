#!/bin/bash

## use for script run only root or sudo 
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi

############### Function to check if a package is installed ##############
check_package() {
    if command -v "$1" &>/dev/null; then
        echo "$1 is already installed."
        return 0
    else
        echo "$1 is not installed."
        return 1
    fi
}

# Function to purge AWS CLI
purge_aws_cli() {
    echo "Purging AWS CLI..."
    sudo apt remove --purge -y awscli
    sudo rm -rf /usr/local/aws /usr/local/bin/aws
    sudo rm -rf awscliv2.zip aws
    echo "AWS CLI has been purged."
}

# Function to install AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."
    sudo apt update -y
    sudo apt install unzip -y
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "AWS CLI installation complete."
    aws --version
}

# Function to purge Terraform
purge_terraform() {
    echo "Purging Terraform..."
    sudo apt remove --purge -y terraform
    sudo rm -rf /usr/local/bin/terraform
    sudo rm -f /etc/apt/sources.list.d/hashicorp.list
    echo "Terraform has been purged."
}

# Function to install Terraform
install_terraform() {
    echo "Installing Terraform..."
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform -y
    echo "Terraform installation complete."
    terraform -version
}

# Function to purge Jenkins
purge_jenkins() {
    echo "Purging Jenkins..."
    sudo apt remove --purge -y jenkins
    sudo rm -f /etc/apt/sources.list.d/jenkins.list
    sudo rm -f /usr/share/keyrings/jenkins-keyring.asc
    sudo apt autoremove -y
    sudo apt clean
    echo "Jenkins has been purged."
}

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    echo "Jenkins installation complete."
    systemctl status jenkins
}

# Function to purge Ansible
purge_ansible() {
    echo "Purging Ansible..."
    sudo apt remove --purge -y ansible
    sudo rm -f /etc/apt/sources.list.d/ansible.list
    sudo apt autoremove -y
    sudo apt clean
    echo "Ansible has been purged."
}

# Function to install Ansible
install_ansible() {
    echo "Installing Ansible..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
    echo "Ansible installation complete."
    ansible --version
}

# Function to handle installation of a specific package
install_package() {
    case "$1" in
        aws)
            if check_package aws; then
                purge_aws_cli
            fi
            install_aws_cli
            ;;
        terraform)
            if check_package terraform; then
                purge_terraform
            fi
            install_terraform
            ;;
        jenkins)
            if systemctl list-units --type=service | grep -q jenkins.service; then
                purge_jenkins
            fi
            install_jenkins
            ;;
        ansible)
            if check_package ansible; then
                purge_ansible
            fi
            install_ansible
            ;;
        all)
            echo "Installing all packages..."
            install_package aws
            install_package terraform
            install_package jenkins
            install_package ansible
            ;;
        *)
            echo "Invalid package: $1"
            ;;
    esac
}



############### Function call as main file work in this ##############
# main_menu() {
#     echo "Choose an option:"
#     echo "1. Install or Update AWS CLI"
#     echo "2. Install or Update Terraform"
#     echo "3. Install or Update Jenkins"
#     echo "4. Install or Update Ansible"
#     echo "5. Install All Packages"
#     echo "6. Exit"
#     read -p "Enter your choice [1-6]: " choice

#     case $choice in
#         1)
#             install_package aws
#             ;;
#         2)
#             install_package terraform
#             ;;
#         3)
#             install_package jenkins
#             ;;
#         4)
#             install_package ansible
#             ;;
#         5)
#             install_package all
#             ;;
#         6)
#             echo "Exiting. Goodbye!"
#             exit 0
#             ;;
#         *)
#             echo "Invalid choice. Please try again."
#             main_menu
#             ;;
#     esac
# }

# # Check system compatibility
# if [ -f /etc/debian_version ]; then
#     echo "Detected Ubuntu/Debian system."
#     main_menu
# else
#     echo "This script is designed for Ubuntu/Debian systems only."
#     exit 1
# fi
