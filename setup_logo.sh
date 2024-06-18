#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" 
  exit 1
fi

# Define the location of the logo file and the config file
LOGO_PATH="/boot/firmware/logo.png"
CONFIG_PATH="/boot/firmware/config.txt"

# Copy the logo file to the /boot/firmware directory
echo "Copying logo.png to /boot/firmware/"
cp logo.png $LOGO_PATH

# Check if the config file exists and append the necessary configuration
if [ -f "$CONFIG_PATH" ]; then
  echo "Updating $CONFIG_PATH"
  tee -a $CONFIG_PATH > /dev/null <<EOT

# Custom boot logo
logo.nologo=1
logo.default_image=/boot/firmware/logo.png

# Disable the rainbow splash screen and other boot messages for a cleaner look
disable_splash=1
consoleblank=0
quiet splash

# Set the background color to black
framebuffer_color=0,0,0
EOT
else
  echo "$CONFIG_PATH not found. Please ensure you are using the correct configuration path."
fi

# Reboot to apply changes
echo "Rebooting to apply changes..."
reboot

