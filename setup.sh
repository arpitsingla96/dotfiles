#!/bin/bash

# Set root password
passwd;

echo "Setting timezone to Asia/Kolkata";
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

echo "Uncomment en_US.UTF-8 UTF-8 from /etc/locale.gen";
vi /etc/locale.gen && locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf;

# Set hostname and hosts
read -p "Hostname: " host_name;
echo "Updating /etc/hosts and /etc/hostname";
echo "$host_name" > /etc/hostname;
echo "
127.0.0.1	localhost
::1	localhost
127.0.1.1	$host_name
" >> /etc/hosts;

# Create a normal user
read -p "Username: " username;
echo "Creating new user and adding it to audio group";
useradd -m -G audio "$username";
passwd "$username";

echo "Installing sudo";
pacman -S sudo;
echo "Add this line in the file:
$username ALL=(ALL) ALL";
editor=vi visudo;

echo "Disabling root login";
passwd -l root;

echo "Now exit, unmount and reboot
exit
umount -R /mnt
reboot";
