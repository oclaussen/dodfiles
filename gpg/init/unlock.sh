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
for recipient in $(cat "${SOURCEDIR}/keys/recipients.txt" | grep -v '^#'); do
  echo "unlock" | gpg --encrypt --recipient "${recipient}" | gpg --decrypt
done

# Keep daemon alive for an hour
sleep 3600
