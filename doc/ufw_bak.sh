##!/bin/sh

# ------------------------------
# UFW & SSH
# ------------------------------

# xbps-install ufw

yes | ufw reset
yes | ufw disable

ufw logging low

# Block incoming and outcoming by default
ufw default deny incoming
ufw default allow outgoing

# DNS Requests
#ufw allow out 53/udp

# HTTP, HTTPS
#ufw allow out 80,443/tcp

# SMTP & IMAP
#ufw allow 25,143,587,993/tcp
#ufw allow out 143,587,993/tcp

# IRC
#ufw allow out 194/tcp
#ufw allow out 6660:7000/tcp

# Instant Messaging
#ufw allow out 6667,1863,5222,5223,8010/tcp

# VOIP & file transfers
#ufw allow out 6891:6900,6901/tcp

# SSH
ufw allow 2120/tcp
#ufw allow out 2120/tcp

# Nginx (Http & https)
#ufw allow 80,443/tcp

# Printer
#ufw allow out 631/tcp
#ufw allow out 8612

# Avahi
#ufw allow out 5353/udp

# Hedgewars
#ufw allow out 46631/tcp

# Warcraft 3 + Blizzard Downloader
#PORTS="1119,1120,3724,4000,6013,6111:6119,6210"
#ufw allow "${PORTS}/tcp"
#ufw allow "${PORTS}/udp"

#ufw allow out "${PORTS}/tcp"
#ufw allow out "${PORTS}/udp"

# Samba
ufw allow 137,138,139,445/tcp

# CalDAV
#ufw allow 5232/tcp

# Last rule: Blocks connections not allowed in rule set
#ufw deny in to any
#ufw deny out to any

# Allow ping
sed -i '/COMMIT/d' /etc/ufw/before.rules

cat >>/etc/ufw/before.rules <<EOF
# allow outbound icmp
-A ufw-before-output -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
-A ufw-before-output -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT
EOF

printf '%s\n' 'COMMIT' >> /etc/ufw/before.rules

#vim /etc/ufw/before.rules # edit COMMIT to the end

yes | ufw enable
