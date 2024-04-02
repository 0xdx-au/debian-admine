#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update package lists
apt-get update

# Install necessary packages
apt-get install -y figlet curl dnsutils tailscale net-tools sudo

# Get the current logged in user, assuming this script is run in the user's session
CURRENT_USER=$(logname)

# Add user to the sudoers group
adduser $CURRENT_USER sudo

# Inform the user about logging out and back in again
echo "Added $CURRENT_USER to sudoers. Please log out and log back in for the changes to take effect."
