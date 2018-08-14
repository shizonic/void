#!/usr/bin/env sh

# ------------------------------
# UFW & SSH
# ------------------------------

yes | ufw reset
yes | ufw disable

ufw logging low

ufw default deny incoming
ufw default allow outgoing

ufw allow in 2120/tcp
ufw allow in 137,138,139,445/tcp

sed -i '/COMMIT/d' /etc/ufw/before.rules

cat >>/etc/ufw/before.rules <<EOF
# allow outbound icmp
-A ufw-before-output -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
-A ufw-before-output -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

# don't delete the 'COMMIT' line or these rules won't be processed
COMMIT
EOF

yes | ufw enable
