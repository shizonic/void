#!/bin/env sh

xbps-install pass gpg pinentry-gtk xdotool

gpg --gen-key

pass init '<pgp-identity-email>'

echo 'pinentry-program /usr/bin/pinentry-gtk' > ~/.gnupg/gpg-agent.conf
