#!/bin/sh

xbps-install vim wget git p7zip rsync tree borg
xbps-install screen xtools xclip inetutils-telnet alsa-utils glances containers redshift
xbps-install mpv youtube-dl gstreamer 
xbps-install gtk-engine-murrine
xbps-install sxiv ii nq rlwrap zathura zathura-pdf-poppler setroot xssstate
xbps-install jq qemu whois 
xbps-install lowdown python3-virtualenv
#xbps-install ruby sup
# task/time tracking
xbps-install task timewarrior

xbps-install rsstail
# camera
xbps-install gphoto2 dcraw netpbm

xbps-install libdvdcss libdvdread libdvdnav

#xbps-install qutebrowser python3-PyQt5-webengine
xbps-install lxappearance sassc

#xbps-install libreoffice

useradd anon
passwd anon
usermod -G wheel -a anon
usermod -G audio -a anon
usermod -G cdrom -a anon
usermod -G kvm -a anon

# modprobe kvm-intel

gpasswd -a anon audio

more /etc/passwd

# redshift service
# Create runit script
mkdir -p /etc/sv/redshift
cat >/etc/sv/redshift/run<<EOF
echo '#!/bin/sh' >> /etc/sv/redshift/run
echo 'exec redshift -c /etc/redshift.conf' >> /etc/sv/redshift/run
EOF
chmod +x /etc/sv/redshift/run
ln -s /run/runit/supervise.redshift /etc/sv/redshift/supervise
ln -s /etc/sv/redshift /var/service
