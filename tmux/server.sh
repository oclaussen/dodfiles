#!/bin/sh
set -eux

tmux has-session -t default || tmux new-session -t default -d
PID=$(tmux display-message -pF '#{pid}')
tail --pid="${PID}" -f /dev/null
