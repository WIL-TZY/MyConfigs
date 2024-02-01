# Linux Commands Cheat Sheet

## OS Shortcuts
- **`CTRL + ALT + T`**: Opens the terminal.

- **`CTRL + ALT + F1`**: Switch to the first virtual terminal (similar to `Ctrl-Alt-Del` on Windows).

- **`CTRL + H (in File Explorer)`**: Display hidden folders (folders starting with `.`).

## System Commands

### Displaying System Information
- **List all block devices**: `lsblk`
- **Disk space usage of all partitions**: `df -h`
- **Detailed info of all partitions**: `sudo fdisk -l`
- **Check system architecture**: `uname -m` (x86_64 means 64-bit)
- **Check kernel version**: `uname -r`
- **Check OS version**: `lsb_release -a`
- **Enable 32-bit architecture on a 64-bit system**: `sudo dpkg --add-architecture i386`
- **Check partition label**: `sudo e2label /dev/sda2`
- **Check available memory**: `free`
- **Find path of application**: `which [app name]`
- **Check computer architecture**: `uname -m`
- **Change permissions of all files in and underneath $HOME**: `sudo chmod 700 "$HOME"`

#### Permissions
```shell
# Command used to change the permissions of a given file
chmod <filename>
# Add the execute permission (x) for all (a) users on a file
chmod a+x
```

#### Get System Information
```shell
uname -a            # Display system information
hostname            # Display the hostname of the Pi
```

#### Get Network Information
```shell
ifconfig            # Display network interfaces and their configurations
hostname -I         # Display the local IP address of the Pi
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
tar -czvf <archive_name.tar.gz> <source_directory>      # Create a compressed archive
tar -xzvf <archive_name.tar.gz>                         # Extract a compressed archive
```

### User Management & Root Commands
```shell
# Switch to root user
sudo su -
# Unlock root - adds a new password
sudo passwd root
# Re-lock root
sudo passwd -dl root
# Display the current username
whoami        
# Add a new user             
sudo adduser <username>     
# Delete a user
sudo userdel <username>     
```
## Terminal Commands

### Update Commands
- **Check available updates for Linux applications**: `sudo apt update`
- **Upgrade updatable Linux applications**: `sudo apt upgrade`
- **List upgradable content**: `apt list --upgradable`
- **Uncompress .xz files**: `unxz`

### Basic Commands
- **List files in the current directory**: `ls`
- **Change the current directory**: `cd`
- **Print the current working directory**: `pwd`
- **Create a new directory**: `mkdir`
- **Remove files**: `rm` 
obs: this only work for empty directories.
To remove a folder with all files inside it recursively, use `sudo rm -r` instead.
- **Remove directories**: `rmdir` 
- **Copy files and directories**: `cp`
- **Move or rename files and directories**: `mv`
- **Create an empty file or update timestamp**: `touch`
- **Concatenate and display file contents**: `cat`
- **Search for a specific pattern in files**: `grep`
- **Search for files and directories**: `find`
- **Change permissions of files and directories**: `chmod`
- **Change owner of files and directories**: `chown`
- **Change group ownership of files**: `chgrp`
- **Execute a command with administrative privileges**: `sudo`
- **Show location of an application**: `which`
- **Execute content of a script within the current shell session**: `source` or `.`

### Environment Variables
- **$HOME**: User's home directory

### Others
- **Open current directory with VSCode**: `code .`
- **Package management command (apt-get or apt)**: Install, update, and remove software packages.
- **Low-level package management command (dpkg)**: For managing individual .deb packages.
- **List all installed programs**: `dpkg -l`
- **Controls and manages system services**: `systemctl`
- **Real-time system monitoring and resource usage**: `top` or `htop`
- **Connect to a remote server using SSH**: `ssh`

## Additional Tips
- **Explore further**: Use the `man` command followed by the command name to access manual pages and learn more about each command's options and usage.

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

