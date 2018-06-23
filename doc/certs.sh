#!/usr/bin/env bash

acmetool quickstart # 1, 2, Y
DOMAIN="<domain>"
acmetool want "${DOMAIN}" "www.${DOMAIN}" "git.${DOMAIN}" "mail.${DOMAIN}"

ls /var/lib/acme/live/*/

cat > /etc/cron.hourly/acmetool << EOT
#!/bin/bash
acmetool reconcile
EOT

# with root, check before passing to SH!
curl https://get.acme.sh | sh

acme.sh --issue -d "${DOMAIN}" --nginx
