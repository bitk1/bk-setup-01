#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Variables
LOGO_PATH="/boot/firmware/logo.png"
CONFIG_PATH="/boot/firmware/config.txt"
BACKUP_PATH="/boot/firmware/config.txt.bak"
PLYMOUTH_THEME_PATH="/usr/share/plymouth/themes/mytheme"
PLYMOUTH_CONFIG="/usr/share/plymouth/themes/mytheme/mytheme.plymouth"
PLYMOUTH_SCRIPT="/usr/share/plymouth/themes/mytheme/mytheme.script"
PLYMOUTH_CONF="/etc/plymouth/plymouth.conf"
INITRAMFS_MODULES="/etc/initramfs-tools/modules"
CMDLINE_PATH="/boot/firmware/cmdline.txt"
CMDLINE_BACKUP="/boot/firmware/cmdline.txt.bak"

# Backup the original config file
if [ ! -f "$BACKUP_PATH" ]; then
  cp "$CONFIG_PATH" "$BACKUP_PATH"
fi

# Backup the original cmdline file
if [ ! -f "$CMDLINE_BACKUP" ]; then
  cp "$CMDLINE_PATH" "$CMDLINE_BACKUP"
fi

# Copy the logo file to /boot/firmware
echo "Copying logo.png to /boot/firmware/"
cp logo.png $LOGO_PATH

# Update the boot configuration
echo "Updating $CONFIG_PATH"
sed -i '/logo.nologo/d' $CONFIG_PATH
sed -i '/logo.default_image/d' $CONFIG_PATH
sed -i '/disable_splash/d' $CONFIG_PATH
sed -i '/consoleblank/d' $CONFIG_PATH
sed -i '/quiet splash/d' $CONFIG_PATH
sed -i '/framebuffer_color/d' $CONFIG_PATH

cat <<EOT >> $CONFIG_PATH

# Custom boot logo
logo.nologo=1
logo.default_image=/boot/firmware/logo.png
disable_splash=1
consoleblank=0
quiet splash
framebuffer_color=0,0,0
EOT

# Create plymouth theme directory
mkdir -p $PLYMOUTH_THEME_PATH

# Create plymouth theme configuration
cat <<EOT > $PLYMOUTH_CONFIG
[Plymouth Theme]
Name=MyTheme
Description=Custom boot and shutdown theme
ModuleName=script

[script]
ImageDir=$PLYMOUTH_THEME_PATH
ScriptFile=$PLYMOUTH_SCRIPT
EOT

# Create plymouth theme script
cat <<EOT > $PLYMOUTH_SCRIPT
message_sprite = ImageSprite("logo.png");
message_sprite.SetPosition(0.5, 0.5, 1.0);
message_sprite.SetScale(1.0, 1.0, 0);
EOT

# Copy the logo to plymouth theme directory
cp logo.png $PLYMOUTH_THEME_PATH/

# Update plymouth to use the custom theme
update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth $PLYMOUTH_CONFIG 100
update-alternatives --set default.plymouth $PLYMOUTH_CONFIG

# Create or update plymouth.conf
echo "[Daemon]" > $PLYMOUTH_CONF
echo "Theme=mytheme" >> $PLYMOUTH_CONF

# Ensure initramfs is configured correctly
grep -qxF '# Plymouth support' $INITRAMFS_MODULES || echo -e "\n# Plymouth support\ndrm\ni915 modeset=1" >> $INITRAMFS_MODULES

# Update initramfs
update-initramfs -u

# Update cmdline.txt
echo "Updating $CMDLINE_PATH"
sed -i '/quiet splash/d' $CMDLINE_PATH
sed -i '/plymouth.ignore-serial-consoles/d' $CMDLINE_PATH

CMDLINE=$(cat $CMDLINE_PATH)
echo "$CMDLINE quiet splash plymouth.ignore-serial-consoles" > $CMDLINE_PATH

# Reboot to apply changes
echo "Rebooting to apply changes..."
reboot

