#!/bin/sh

CARDS_DIR="${HOME}/.gnupg/cards"
CARDS_USB_DEVICE="1050:0116" # TODO: don't hardcode this
GPG_AGENT_SOCKET="/data/gpg-agent/S.gpg-agent"

init_agent() {
  rm -f /var/run/pcscd/*
  pcscd
  gpg-agent --daemon
  gpg --card-status
}

check_usb() {
  lsusb -d "${CARDS_USB_DEVICE}" > /dev/null
}

is_agent_running() {
  echo '/echo test-agent' \
      | gpg-connect-agent --no-autostart --raw-socket "${GPG_AGENT_SOCKET}" \
      > /dev/null 2>&1
}

list_cards() {
  ls "${CARDS_DIR}"/*.txt
}

current_card() {
  for cardfile in $(list_cards); do
    if check_card "${cardfile}"; then echo "${cardfile}"; return 0; fi
  done
  return 1
}

unlock_any_card() {
  for cardfile in $(list_cards); do
    if unlock_card "${cardfile}"; then return 0; fi
  done
  return 1
}

unlock_card() {
  card=$1
  for recipient in $(list_recipients "${card}"); do
    unlock_recipient "${recipient}"
  done
}

check_card() {
  card=$1
  for recipient in $(list_recipients "${card}"); do
    if ! check_recipient "${recipient}"; then return 1; fi
  done
  return 0
}

list_recipients() {
  card=$1
  grep -v '^#' < "${card}"
}

unlock_recipient() {
  recipient=$1
  echo "unlock" \
      | gpg --encrypt --recipient "${recipient}" 2> /dev/null \
      | gpg --decrypt 2> /dev/null
}

check_recipient() {
  recipient=$1
  gpg --list-secret-keys 2> /dev/null \
      | grep -q "${recipient}"
}
