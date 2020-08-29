#!/bin/sh
set -eux

SOURCEDIR=$(dirname $0)

# Start smart card daemon
rm -f /var/run/pcscd/*
pcscd

# Run agent
gpg-agent --daemon

# Fetch secret keys from smart card
gpg --card-status

# Cache secret keys in daemon
load_key() {
  echo "unlock" | gpg --encrypt --recipient "$1" | gpg --decrypt
}
for recipient in $(cat "${SOURCEDIR}/keys/recipients.txt" | grep -v '^#'); do
  load_key "${recipient}" || echo "could not find private key for ${recipient}"
done

# Keep daemon alive for an hour
sleep 3600
