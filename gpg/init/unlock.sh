#!/bin/sh
set -eux

# Start smart card daemon
rm -f /var/run/pcscd/*
pcscd

# Run agent
gpg-agent --daemon

# Fetch secret keys from smart card
gpg --card-status

# Cache secret keys in daemon
echo "unlock" | gpg --encrypt --recipient claussen.ole@gmail.com | gpg --decrypt

# Keep daemon alive for 8 hours
sleep 43200
