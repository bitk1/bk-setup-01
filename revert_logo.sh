#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Variables
CONFIG_PATH="/boot/firmware/config.txt"
BACKUP_PATH="/boot/firmware/config.txt.bak"
PLYMOUTH_THEME_PATH="/usr/share/plymouth/themes/mytheme"
PLYMOUTH_CONF="/etc/plymouth/plymouth.conf"
INITRAMFS_MODULES="/etc/initramfs-tools/modules"
CMDLINE_PATH="/boot/firmware/cmdline.txt"
CMDLINE_BACKUP="/boot/firmware/cmdline.txt.bak"

# Restore the original config file
if [ -f "$BACKUP_PATH" ]; then
  echo "Restoring original $CONFIG_PATH"
  cp "$BACKUP_PATH" "$CONFIG_PATH"
fi

# Restore the original cmdline file
if [ -f "$CMDLINE_BACKUP" ]; then
  echo "Restoring original $CMDLINE_PATH"
  cp "$CMDLINE_BACKUP" "$CMDLINE_PATH"
fi

# Remove custom plymouth theme
echo "Removing custom plymouth theme"
update-alternatives --remove default.plymouth $PLYMOUTH_THEME_PATH/mytheme.plymouth

# Remove plymouth.conf
if [ -f "$PLYMOUTH_CONF" ]; then
  rm "$PLYMOUTH_CONF"
fi

# Remove plymouth support from initramfs-tools/modules
sed -i '/# Plymouth support/,+2d' $INITRAMFS_MODULES

# Update initramfs
update-initramfs -u

# Reboot to apply changes
echo "Rebooting to apply changes..."
reboot

