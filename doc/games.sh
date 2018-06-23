#!/bin/sh

xbps-install hedgwars ImageMagick mercurial

xbps-install void-repo-multilib
xbps-install wine-32bit winetricks
xbps-install playonlinux

# winetricks corefonts wine-mono
winetricks dotnet461

#wine msiexec /i /usr/share/wine/mono/wine-mono-4.7.1.msi

xbps-install mesa-{ati,intel}-dri-32bit
xbps-install libtxc_dxtn-32bit

#wget http://dl.heroesofnewerth.com/installers/linux/HoNClient.sh
#./HoNClient.sh
# xbps-install alsa-lib GConf gtk+ nss libXScrnSaver libjpeg-turbo cgmanager ncurses-devel libgcrypt freetype
#xbps-install GConf cgmanager ncurses-devel

xbps-install steam
