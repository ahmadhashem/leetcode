#!/bin/bash

# Define the local subnet we want to advertise
SUBNET="192.168.178.0/24"

echo "v2 running"

NETDEV=$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")
sudo ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off

printf '#!/bin/sh\n\nethtool -K %s rx-udp-gro-forwarding on rx-gro-list off \n' "$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")" | sudo tee /etc/networkd-dispatcher/routable.d/50-tailscale
sudo chmod 755 /etc/networkd-dispatcher/routable.d/50-tailscale


sudo /etc/networkd-dispatcher/routable.d/50-tailscale
test $? -eq 0 || echo 'An error occurred.'



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
