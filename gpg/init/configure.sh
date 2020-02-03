#!/bin/sh
set -eux

SOURCEDIR=$(dirname $0)

chmod 700 "${GNUPGHOME}"

# Copy config files
configs="gpg.conf gpg-agent.conf trustlist.txt"
for file in ${configs}; do
  install -m 600 "${SOURCEDIR}/${file}" "${GNUPGHOME}"
done

# Import all public keys
for file in $(ls "${SOURCEDIR}/keys"); do
  gpg --import "${SOURCEDIR}/keys/${file}"
done
