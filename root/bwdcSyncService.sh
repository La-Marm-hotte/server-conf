#!/bin/bash

# install bwdc according to these instructions: https://bitwarden.com/help/article/directory-sync-cli/
# set BITWARDENCLI_CONNECTOR_PLAINTEXT_SECRETS=true in /etc/environment and reboot

# install a cron job to run this script, every days at 1:00 with crontab -e


LOG_FILE="/var/log/bwdc/sync.log"
DATE=$(date -Iseconds)

echo "[$DATE] Syncing LDAP to Bitwarden" >> "$LOG_FILE"
# configuration is read from /root/.config/Bitwarden\ Directory\ Connector/data.json
bwdc sync >> "$LOG_FILE"
