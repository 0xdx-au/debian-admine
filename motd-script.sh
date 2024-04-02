#!/bin/sh

# Print "admine" in green
echo "\e[32m"
figlet admine
echo "\e[0m"

# Function to create a table header
print_table_header() {
    echo "---------------------|-----------------------------"
    printf "%-20s | %-27s\n" "$1" "$2"
    echo "---------------------|-----------------------------"
}

# OS Information
print_table_header "OS Information" ""
printf "%-20s | %-27s\n" "OS" "$(lsb_release -d | cut -f2-)"
printf "%-20s | %-27s\n" "Version" "$(lsb_release -r | cut -f2-)"
echo ""

# Network Information
print_table_header "Network Information" ""
printf "%-20s | %-27s\n" "Hostname" "$(hostname)"
printf "%-20s | %-27s\n" "Local IP" "$(hostname -I | cut -d' ' -f1)"
printf "%-20s | %-27s\n" "Public IP" "$(curl -s https://api.ipify.org)"
# NTP Server
ntp_server=$(timedatectl show-timesync --all | grep ServerAddress= | cut -d= -f2)
if [ -z "$ntp_server" ]; then
    ntp_server="Not Available"
fi
printf "%-20s | %-27s\n" "NTP Server" "$ntp_server"
echo ""

# Filesystem Information
print_table_header "Filesystem" ""
df -h | grep -E '^Filesystem|/dev/' | awk '{printf "%-20s | %-27s\n", $1, $2" "$3" "$4}'
echo ""

# Tailscale Status
tailscale_ip=$(ip -o -4 addr list tailscale0 | awk '{print $4}' | cut -d/ -f1)
print_table_header "Tailscale Status" ""
if [ -z "$tailscale_ip" ]; then
    printf "%-20s | %-27s\n" "Tailscale" "Disconnected"
else
    printf "%-20s | %-27s\n" "Tailscale" "Connected"
    printf "%-20s | %-27s\n" "IP Address" "$tailscale_ip"
fi
echo ""

# User Details
print_table_header "User Details" ""
printf "%-20s | %-27s\n" "Last Login" "$(last -i | grep -m 1 'logged in')"
echo ""
