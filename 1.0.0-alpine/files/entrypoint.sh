#!/bin/sh
set -ex

POSTFIX_CONFIG="/etc/postfix/main.cf"
SMTP_AUTH="/etc/postfix/smtp_auth"

function mysed() {
    sed -i 's,{'$1'},'$2',g' $3
}
# Set Environment Variables in Config
mysed HOSTNAME $HOSTNAME $POSTFIX_CONFIG

# Domain for Outgoing Mail
mysed DOMAIN $DOMAIN $POSTFIX_CONFIG
# Relahost to Send Mails
mysed RELAYHOST $RELAYHOST $POSTFIX_CONFIG
mysed RELAYHOST $RELAYHOST $SMTP_AUTH
# RELAY User and Password
mysed RELAY_USER $RELAY_USER $SMTP_AUTH
mysed RELAY_PASSWORD $RELAY_PASSWORD $SMTP_AUTH
postmap $SMTP_AUTH
# Allow only MISP Docker Container Access
mysed DOCKER_NETWORK $DOCKER_NETWORK $POSTFIX_CONFIG
# You need to get more postfix output for a specified host normally the relayhost or misp-server
[ $DEBUG_PEER == "none" ] || mysed DEBUG_PEER $DEBUG_PEER $POSTFIX_CONFIG
[ $DEBUG_PEER == "none" ] && mysed DEBUG_PEER "" $POSTFIX_CONFIG

exit 0
# Start Postfix
/usr/lib/postfix/post-install meta_directory=/etc/postfix create-missing
/usr/lib/postfix/master


# Check Postfix configuration
postconf -c /etc/postfix/

if [[ $? != 0 ]]; then
  echo "Postfix configuration error, refusing to start."
  exit 1
else
  postfix -c /etc/postfix/ start
  sleep 126144000
fi