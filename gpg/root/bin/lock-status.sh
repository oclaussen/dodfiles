#!/bin/sh
set +ex

gpg --list-keys > /dev/null 2>&1
result=$?

if [ $result != 0 ]; then
  echo "error"
  exit 1
fi

for cardfile in $(ls /home/dodo/.gnupg/cards/*.txt); do
  good=true

  for recipient in $(cat "${cardfile}" | grep -v '^#'); do
    gpg --list-secret-keys | grep -q "${recipient}"
    result=$?

    if [ $result != 0 ]; then
      good=false
    fi
  done

  if [ "${good}" = true ]; then
    echo $(basename "${cardfile}" .txt)
    exit 0
  fi
done

echo "locked"
