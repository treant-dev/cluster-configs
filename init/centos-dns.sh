#!/bin/bash
# Restart NetworkManager to apply changes after yum upgrade / update
sudo systemctl restart NetworkManager
# Get the active connection name in NetworkManager, e.g., "Wired connection 1" or "eth0".
# You can use 'nmcli connection show' to list all active connections if needed.
CONNECTION_NAME=$(nmcli -t -f NAME connection show --active | head -n 1)

# If no active connection is found, show an error and exit.
if [[ -z "$CONNECTION_NAME" ]]; then
  echo "Error: No active connection found. Please check NetworkManager."
  exit 1
fi

echo "Disabling automatic DNS configuration for connection: $CONNECTION_NAME"

# Disable automatic DNS through DHCP and set static DNS for IPv4 and IPv6
nmcli connection modify "$CONNECTION_NAME" ipv4.ignore-auto-dns yes
nmcli connection modify "$CONNECTION_NAME" ipv6.ignore-auto-dns yes

# Set Cloudflare as the primary DNS and Google as the secondary for IPv4
nmcli connection modify "$CONNECTION_NAME" ipv4.dns "1.1.1.1,8.8.8.8"

# Set only Cloudflare for IPv6
nmcli connection modify "$CONNECTION_NAME" ipv6.dns "2606:4700:4700::1111"

# Apply the changes and restart the connection
echo "Applying settings..."
nmcli connection up "$CONNECTION_NAME"

# Check and display the contents of /etc/resolv.conf to verify the changes
echo "Checking /etc/resolv.conf:"
cat /etc/resolv.conf

echo "DNS setup complete. Now using Cloudflare and Google DNS for IPv4, and only Cloudflare for IPv6."