#!/bin/sh
set -eux

SOURCEDIR=$(dirname $0)

# Sanity check arguments
CARDNAME="$1"
if [ -z "${CARDNAME}" ]; then
  echo "Specify card name"
  exit 1
fi

RECIPIENTS="${SOURCEDIR}/cards/${CARDNAME}.txt"
if [ ! -f "${RECIPIENTS}" ]; then
  echo "No configuration for ${CARDNAME}"
  exit 1
fi

# Start smart card daemon
rm -f /var/run/pcscd/*
pcscd

# Run agent
gpg-agent --daemon

# Fetch secret keys from smart card
gpg --card-status

# Cache secret keys in daemon
for recipient in $(cat "${RECIPIENTS}" | grep -v '^#'); do
  echo "unlock" | gpg --encrypt --recipient "${recipient}" | gpg --decrypt
done

# Keep daemon alive for an hour
sleep 3600
