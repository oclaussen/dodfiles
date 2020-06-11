#!/bin/sh
set -eux

SOURCEDIR=$(dirname $0)

chmod 700 "${GNUPGHOME}"

# Copy config files
configs="gpg.conf gpg-agent.conf"
for file in ${configs}; do
  install -m 600 "${SOURCEDIR}/${file}" "${GNUPGHOME}"
done

# Import all public keys
for file in $(ls ${SOURCEDIR}/keys/0x*.txt); do
  gpg --import "${file}"
done

# Trust public keys in list
for key in $(cat "${SOURCEDIR}/keys/trustlist.txt" | grep -v '^#'); do
  echo $key | gpg --import-ownertrust
done
