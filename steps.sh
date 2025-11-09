#!/bin/bash

# Define the local subnet we want to advertise
SUBNET="192.168.178.0/24"

echo "Starting Tailscale installation and configuration..."

# --- 1. Installation ---
echo "1. Installing Tailscale..."
# Add Tailscale key and repository, then install
curl -fsSL https://tailscale.com/install.sh | sh

# --- 2. Enable IP Forwarding ---
echo "2. Enabling IP Forwarding for routing..."
# This is crucial for both Exit Node and Subnet Router functionality
# Enable IPv4 forwarding
if ! grep -q 'net.ipv4.ip_forward = 1' /etc/sysctl.conf; then
    echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
fi
# Enable IPv6 forwarding
if ! grep -q 'net.ipv6.conf.all.forwarding = 1' /etc/sysctl.conf; then
    echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
fi

# Apply the changes immediately
sudo sysctl -p

# --- 3. Start Tailscale and Advertise Routes ---
echo "3. Starting Tailscale and advertising routes and exit node status."
echo "   You will be prompted to authenticate by visiting a URL."

# Start Tailscale, advertise as Exit Node, and advertise the local LAN subnet
sudo tailscale up \
    --advertise-exit-node \
    --advertise-routes="${SUBNET}"

# --- 4. Final Instructions ---
echo "------------------------------------------------------"
echo "✅ Tailscale is installed and configured on this server."
echo "------------------------------------------------------"
echo "👉 MANUAL STEP REQUIRED:"
echo "1. Visit the URL provided above to authenticate this machine."
echo "2. Log into the Tailscale Admin Console (https://login.tailscale.com/admin)."
echo "3. Go to the 'Machines' page."
echo "4. Find this server, click the three-dot menu, and select 'Edit route settings'."
echo "5. **Check the box** next to 'Use as exit node'."
echo "6. **Check the box** next to the advertised subnet: ${SUBNET}."
echo "7. Click 'Save'."
echo ""
echo "Once these steps are complete, this server will be an active Exit Node and Subnet Router."
