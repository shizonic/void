#!/bin/sh

# https://www.vultr.com/docs/how-to-setup-dynamic-dns

cd ~/dev

git clone https://github.com/andyjsmith/Vultr-Dynamic-DNS.git vultrddns && cd vultrddns

# edit config.json

xbps-install python3-requests

crontab -e
# edit user crontab
# */30 * * * * python3 /home/<USER>/dev/vultrddns/ddns.py > /dev/null 2>&1
