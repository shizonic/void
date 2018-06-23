#!/usr/bin/env sh

xbps-install python3-pip
pip install --upgrade radicale
pip install --upgrade passlib bcrypt

mkdir -p /etc/sv/radicale
cat > /etc/sv/radicale/run <<EOT
exec radicale
EOT
chmod +x /etc/sv/radicale/run
ln -s /run/runit/supervise.radicale /etc/sv/radicale/supervise

ln -s /etc/sv/radicale /var/service

mkdir -p /var/lib/radicale/collections

mkdir /etc/radicale
cat > /etc/radicale/config <<EOT
[auth]
type = htpasswd
htpasswd_filename = /etc/radicale/users
# encryption method used in the htpasswd file
htpasswd_encryption = plain
EOT

cat > /etc/radicale/users <<EOT
pub:<PASSWORD>
EOT
