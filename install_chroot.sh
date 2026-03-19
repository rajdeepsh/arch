#!/usr/bin/env bash
set -euo pipefail

# Set timezone
ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
hwclock --systohc

# Set locale
sed -i 's/^#en_US\.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=us" >/etc/vconsole.conf

# Set hostname
echo "arch" >/etc/hostname

# Set root password
echo "$1" | passwd root --stdin

# Create sudo user
useradd -m -G wheel -s /bin/bash rajdeep
echo "$1" | passwd rajdeep --stdin
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Set parallel downloads
sed -i 's/^ParallelDownloads = [0-9]\+/ParallelDownloads = 20/' /etc/pacman.conf

# Enable color
sed -i 's/^#Color/Color/' /etc/pacman.conf

# Add candy
sed -i '/^ParallelDownloads = 20/a ILoveCandy' /etc/pacman.conf

# Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Install packages
pacman -Syu --noconfirm --needed - < /arch/pkglist.txt

# Setup greetd
mkdir -p /etc/greetd && cp /arch/config.toml /etc/greetd/