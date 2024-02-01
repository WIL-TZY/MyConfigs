#!/bin/bash

# Check if the user has root (admin) privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# Install the required dependencies
apt-get update
apt-get install -y libcurl4 libopenal1

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "Dependencies (libcurl4 and libopenal1) installed successfully."
else
    echo "Failed to install dependencies."
fi

# OBS: In the terminal, navigate to the directory where you saved your script and make it executable with the following command: chmod +x thisFileName.sh

# Run the script with administrator privileges: sudo ./install_dependencies.sh
