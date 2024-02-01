#!/bin/bash

# Location of pacman executable (adjust this to your MSYS2 installation)
pacman_exe="/usr/bin/pacman"

# Check if the lock file exists and remove it if it does
lock_file="/var/lib/pacman/db.lck"
if [ -e "$lock_file" ]; then
    echo "Removing pacman database lock..."
    rm "$lock_file"
fi

# List of packages to remove
packages=$(pacman -Q | awk '/mingw-w64-ucrt-x86_64-/ {print $1}')

# Uninstall packages forcefully without checking dependencies
for package in $packages; do
    $pacman_exe -Rdd --noconfirm "$package"
done

# Optional pause to keep the terminal open
read -p "Press Enter to exit..."

# Make this script executable by using this command: chmod +x uninstall_mingw.sh
