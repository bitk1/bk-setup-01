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

# Restore the original config file
if [ -f "$BACKUP_PATH" ]; then
  echo "Restoring original $CONFIG_PATH"
  cp "$BACKUP_PATH" "$CONFIG_PATH"
fi

# Remove custom plymouth theme
echo "Removing custom plymouth theme"
update-alternatives --remove default.plymouth $PLYMOUTH_THEME_PATH/mytheme.plymouth

# Update initramfs
update-initramfs -u

# Reboot to apply changes
echo "Rebooting to apply changes..."
reboot

