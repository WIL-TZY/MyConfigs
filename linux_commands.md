# Linux Cheat Sheet

### OS Shortcuts
- **`CTRL + ALT + T`**: Opens the terminal.

- **`CTRL + ALT + F1`**: Switch to the first virtual terminal (similar to `Ctrl-Alt-Del` on Windows).

- **`CTRL + H (in File Explorer)`**: Display hidden folders (folders starting with `.`).

## Commands

#### Basic Commands
```shell
ls                          # List files in the current directory
cd                          # Change the current directory
pwd                         # Print the current working directory
mkdir                       # Create a new directory
rm                          # Remove files (note: works for empty directories; to remove a folder with all files inside it recursively, use sudo rm -r)
rmdir                       # Remove directories
cp                          # Copy files and directories
mv                          # Move or rename files and directories
touch                       # Create an empty file or update timestamp
cat                         # Concatenate and display file contents
grep                        # Search for a specific pattern in files
find                        # Search for files and directories
which                       # Show the location of an application
source                      # Execute content of a script within the current shell session (.)
```

#### System Information
```shell
lsblk                           # List all block devices
df -h                            # Disk space usage of all partitions
hostname                        # Display the hostname
sudo fdisk -l                    # Detailed info of all partitions
uname -a                        # Display system information
uname -m                         # Check computer architecture
uname -r                         # Check kernel version
lsb_release -a                   # Check OS version
sudo dpkg --add-architecture i386 # Enable 32-bit architecture on a 64-bit system
sudo e2label /dev/sda2           # Check partition label
free                             # Check available memory (RAM)
which <app name>                 # Find path of application
```

#### Permissions, Ownership
```shell
chmod <filename>    # Command used to change the permissions of a given file (need params)
chmod a+x           # Add the execute permission (x) for all (a) users on a file
chown                       # Change owner of files and directories
chgrp                       # Change group ownership of files
sudo chmod 700 "$HOME"           # Change permissions of all files in and underneath $HOME
```

#### Network Information
```shell
ifconfig            # Display network interfaces and their configurations
hostname -I         # Display the local IP address
```
#### Process Management
```shell
top              # Display a dynamic view of system processes
ps               # Display a snapshot of current processes
kill <pid>       # Terminate a process using its process ID
```

#### SSH (Secure Shell)
```shell
ssh <username>@<hostname_or_ip>   # Connect to another machine via SSH
```

#### Compression and Decompression
```shell
tar -czvf <archive_name.tar.gz> <source_directory>          # Create a compressed archive
tar -xzvf <archive_name.tar.gz>                         # Extract a compressed archive
dpkg                        # Low-level package management command - For managing individual .deb packages
dpkg -l                     # List all installed programs
unxz                        # Uncompress .xz files
```

#### User Management & Super Root Privileges
```shell
sudo su -                   # Switch to root user
sudo passwd root            # Unlock root - adds a new password
sudo passwd -dl root        # Re-lock root
whoami                      # Display the name of the current user                     
sudo adduser <username>     # Add a new user    
sudo userdel <username>     # Delete a user    
```

#### Update Commands
```shell
sudo apt                    # Package management command to install, update, and remove software packages (apt-get or apt)
sudo apt update             # Check available updates for Linux applications
sudo apt upgrade            # Upgrade updatable Linux applications
apt list --upgradable       # List upgradable content
```

#### Environment Variables
```shell
echo $HOME                  # User's home directory
```

#### Other Commands
```shell
code .                      # Open the current directory with VSCode
systemctl                   # Controls and manages system services
ssh                         # Connect to a remote server using SSH
```

#### Additional Tips
> Use the `man` command followed by the command name to access manual pages and learn more about each command's options and usage.

## Raspberry Pi Commands

#### Open main configurations
```shell
sudo raspi-config
```
#### System Reboot and Shutdown
```shell
sudo reboot             # Reboot the Raspberry Pi
sudo shutdown -h now    # Shutdown the Raspberry Pi immediately
```
