#!/bin/sh

DEFAULT_SIDEBAR_SIZE="40%"
DEFAULT_WINDOW_NUMBER="99"
DEFAULT_WINDOW_NAME="sidebar"
DEFAULT_COMMAND="/bin/bash"

get_or_default_option() {
  option=$1
  default=$2
  value=$(tmux show-option -gqv "${option}")

  if [ -z "${value}" ]; then
    value="${default}"
  fi

  echo "${value}"
}

get_or_set_option() {
  option=$1
  set_value=$2
  result=""

  if [ -n "${set_value}" ]; then
    tmux set-option -gq "${option}" "${set_value}"
    result="${set_value}"
  else
    result=$(tmux show-option -gqv "${option}")
  fi

  echo "${result}"
}

unset_option() {
  option=$1
  tmux set-option -gu "${option}"
}

sidebar_size() {
  get_or_default_option "@sidebar-size" "${DEFAULT_SIDEBAR_SIZE}"
}

sidebar_window_name() {
  get_or_default_option "@sidebar-window-name" "${DEFAULT_WINDOW_NAME}"
}

sidebar_window_number() {
  get_or_default_option "@sidebar-window-number" "${DEFAULT_WINDOW_NUMBER}"
}

sidebar_command() {
  get_or_default_option "@sidebar-command" "${DEFAULT_COMMAND}"
}

sidebar_pane() {
  get_or_set_option "@-sidebar-pane-id" "$@"
}

last_pane() {
  get_or_set_option "@-sidebar-last-pane-id" "$@"
}

current_pane() {
  tmux display-message -p '#{pane_id}'
}

current_window() {
  tmux display-message -p '#{window_id}'
}

sidebar_exist() {
  test -n "$(sidebar_pane)"
}

sidebar_active() {
  test "$(current_pane)" = "$(sidebar_pane)" 
}

sidebar_visible() {
  tmux list-panes -F "#{pane_id}" 2>/dev/null | grep -q "$(sidebar_pane)"
}

sidebar_create() {
  pane_id="$(tmux new-window -d \
                  -n "$(sidebar_window_name)" \
                  -t "$(sidebar_window_number)" \
                  -P -F '#{pane_id}' \
                  "$(sidebar_command)")"
  sidebar_pane "${pane_id}"
}

sidebar_remove() {
    tmux kill-pane -t "$(sidebar_pane)"
    unset_option "@-sidebar-pane-id"
}

sidebar_hide() {
  if sidebar_active; then
    tmux select-pane "$(last_pane)"
  fi

  tmux break-pane -d \
       -s "$(sidebar_pane)" \
       -n "$(sidebar_window_name)" \
       -t "$(sidebar_window_number)"
}

sidebar_show() {
  last_pane "$(current_pane)"
  tmux join-pane -f -h \
       -l "$(sidebar_size)" \
       -s "$(sidebar_pane)" \
       -t "$(current_pane)"
  tmux select-pane -t "$(last_pane)"
}

sidebar_toggle() {
  sidebar_exist || sidebar_create
  if sidebar_visible; then sidebar_hide; else sidebar_show; fi
}
