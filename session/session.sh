#!/bin/sh
set -eux

tmuxinator start default
PID=$(tmux display-message -pF '#{pid}')
tail --pid="${PID}" -f /dev/null
