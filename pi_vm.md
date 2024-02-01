
## Lite versions
It's a quicker install, possible by using `QEMU` and the GUI with `virt-manager`: [guide here](https://dominoc925.blogspot.com/2021/10/use-virtual-machine-manager-to-create.html?m=1&fbclid=IwAR3yQbdF_bnP6fzOiW6xfRYmljqlz7nJudSjZU1mtfdOpljL30-A0p_cskg).

Use the `-display none` parameter with CLI-based OS such as the lite versions of `Raspberry Pi OS`.

## Desktop versions

### 1. Downloading and extracting files

These instructions can be performed on a native Linux system, or on a Windows Subsystem for Linux (WSL). 

They cannot be done on Windows.

Download the OS image from the [official website](https://www.raspberrypi.com/software/operating-systems/).

Alternatively, you can download it directly from the terminal. This works for both the Lite and the Desktop edition:

```shell 
curl <link-to-raspios> -o raspios.img.xz
```

Decompress the file using the `xz` command:
```shell 
xz -dk raspios.img.xz
```

> It's recommended to keep the original image even after decompressing.

### 2. Mount the image to a specific mount directory
Create the directory.
```shell
sudo mkdir /mnt/rpi
```

Create the loop point.
```shell
sudo losetup -f --show -P $(pwd)/raspios.img
```

Mount.
```shell
sudo mount /dev/loop<no>p1 /mnt/rpi
```

### 3. Extract out the kernel and all the dtb files from the image
Make a directory for the `.dtb` files.
```shell
mkdir dtbs
```

Copy all the kernel files.
```shell
cp /mnt/rpi/kernel* .
```

Copy all `.dtb` files.
```shell
cp /mnt/rpi/*.dtb dtbs
```

### 4. Remove password for the user pi

> This is an important step! Do **not** skip.

In earlier versions of Raspberry Pi OS (Raspbian), the default combo for username & password were: 
```
Username: pi
Password: raspberry
```

However, in the latest versions, it no longer have the default username-password combo as `pi:raspberry`. 

According to its documentation, the `Raspberry Pi OS` also allows for setting up of the default password in the image it writes.

In our case, since we manually downloaded the built image directly, we have not set any **default password**.

We therefore will simply mount the root-fs of the Raspberry Pi like how we mounted the kernel partition above:
```shell
sudo umount /mnt/rpi
sudo mount /dev/loop<no>p2 /mnt/rpi
```

Edit the file `/mnt/rpi/etc/passwd` to empty the password for the `pi` user:

    sudo vi /mnt/rpi/etc/passwd

> `Obs:` The `vi` is for the Vim text editor, but you could use any other text editor of your choice (e.g.: `nano`). 

Search for this line in the file:
```
pi:x:1000:1000:,,,:/home/pi:/bin/bash
```

and remove the `x` after `pi:`. Now save the file. 

By doing this, you have made it easy to log into the `Raspberry Pi OS` as soon as `QEMU` boots with it.

The line should now look like this:
```
pi::1000:1000:,,,:/home/pi:/bin/bash
```

### 5. Unmount the image

You’ll not need it any more.

```shell
sudo umount /mnt/rpi
sudo losetup -d /dev/loop<no>
```

# Installing QEMU

Download `QEMU` for Ubuntu with the following command:

```shell
sudo apt-get install qemu-system-arm qemu-efi
```

Create a `QEMU`-compatible `Raspberry Pi OS` image:

> `Obs:` This is optional but strongly **recommended**.

The Rpi image downloaded above is a raw format image. 
Converting this to `qcow2` format makes it very performant while use with `QEMU`, and also occupies lesser space on host machine.

Additionally, you can also increase the SD card size to `8GB` so that you can later use all that space for installation of additional software in run-time.

```shell
### Convert the raw image to QEMU qcow2 format
qemu-img convert -f raw -O qcow2 raspios.img raspios.qcow 

### Resize the image to 8GB (it should be a power of 2)    
qemu-img resize raspios.qcow 8G

### Remove existing raspberry pi os raw image from disk so you don't get confused and accidentally use it
rm -f raspios.img
```

# Start `Raspberry Pi OS`

The instructions below work on both Windows and Linux (or WSL) systems.

Of course, on Windows, you will not use the `sudo`command before `qemu-system-aarch64`.

> This works with the most recent `QEMU` version `7.0.0`, but also works with `QEMU` version `5.2`.

### Start QEMU with RPI emulation

> **Important**: This command needs to be executed in `sudo` mode! Use the `sudo su` command to swap to super user in your host machine's terminal.

Also, it has already been automated in the `vm.sh` script inside the `/pi` directory so you don't have to re-type it everytime.

### Lite version 
```shell
sudo qemu-system-aarch64 \
-M raspi3b \
-display none \
-append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
-dtb ./dtbs/bcm2710-rpi-3-b-plus.dtb 
-sd raspios.qcow \
-kernel kernel8.img \
-m 1G \
-smp 4 \
-serial mon:stdio \
-usb \
-device usb-mouse \
-device usb-kbd \
-device usb-net,netdev=net0 \
-netdev user,id=net0,hostfwd=tcp::5555-:22
```

This will start up `QEMU` with Raspberry Pi on the console. 

### Desktop version
```shell
sudo qemu-system-aarch64 \
-M raspi3b \
-append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1"
-dtb ./dtbs/bcm2710-rpi-3-b-plus.dtb
-sd raspios.qcow
-kernel kernel8.img
-m 1G
-smp 4
-serial mon:stdio -usb -device usb-mouse
-device usb-kbd
-device usb-net,netdev=net0
-netdev user,id=net0,hostfwd=tcp::5555-:22
```
> Note the only difference here is that for the desktop version you shouldn't use the `-display none` parameter.

When it prompts you for the login and password, just type in "pi" and press `ENTER`. 

And then you will drop into the `Raspberry Pi OS`’s terminal. 

> You can get the root shell by simply typing `sudo bash` on the command prompt of the guest machine.

That's it! `Raspberry Pi OS` VM was successfully installed using `QEMU`.

## Resizing the SD card size

With all this done to successfully start   `QEMU`, we’ll hit the next problem: the size of the SD card (which hosts the OS and the files in the home-directory of the pi user) would be ridiculously small — about 1.6GB, and most of this is already used up by the base system!

So, we will have to now increase the size of the card so that any useful work can be done with this emulated Rpi.

Now. create a file `/etc/udev/rules.d/90-qemu.rules` in the guest Raspberry Pi OS:

```shell
sudo vi /etc/udev/rules.d/90-qemu.rules
```

Add these contents in the file:

```
KERNEL=="sda", SYMLINK+="mmcblk0"
KERNEL=="sda?", SYMLINK+="mmcblk0p%n"
KERNEL=="sda2", SYMLINK+="root"
```

Now, shutdown `QEMU` — `sudo shutdown -h now` — and restart it again with the command-line as above.

After QEMU has gotten back, log into it as pi again, and start `raspi-config` as root:

```shell
sudo raspi-config
```

In the curses-window that shows up, select `Advanced Options` and then `Expand Filesystem`.

This will expand the filesystem to fill up the original image size of about 8GB. After resizing, you will have to reboot `QEMU` to use all the expanded space.

---
> `Obs:` This guide written in markdown is an adaptation of this [Medium post](https://blog.ramdoot.in/emulating-raspberry-pi-on-with-qemu-951283daf2bd#83ca).
