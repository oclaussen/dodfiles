#!/bin/sh
set -eux

export GEM_HOME="/opt/ruby/bundle"
/opt/ruby/bundle/bin/tmuxinator start default
PID=$(tmux display-message -pF '#{pid}')
tail --pid="${PID}" -f /dev/null
