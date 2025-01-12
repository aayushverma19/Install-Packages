#!/bin/bash
set -e

. Install.sh

main_menu() {
    echo "Choose an option:"
    echo "1. Install or Update AWS CLI"
    echo "2. Install or Update Terraform"
    echo "3. Install or Update Jenkins"
    echo "4. Install or Update Ansible"
    echo "5. Install All Packages"
    echo "6. Exit"
    read -p "Enter your choice [1-6]: " choice

    case $choice in
        1)
            install_package aws
            ;;
        2)
            install_package terraform
            ;;
        3)
            install_package jenkins
            ;;
        4)
            install_package ansible
            ;;
        5)
            install_package all
            ;;
        6)
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            main_menu
            ;;
    esac
}

# Check system compatibility
if [ -f /etc/debian_version ]; then
    echo "Detected Ubuntu/Debian system."
    main_menu
else
    echo "This script is designed for Ubuntu/Debian systems only."
    exit 1
fi
