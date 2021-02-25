#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

BOLD='\033[1m'
ITALIC='\033[3m'
NORMAL="\033[0m"

color_print() {
  if [ -t 1 ]; then
    echo -e "$@$NORMAL"
  else
    echo "$@" | sed "s/\\\033\[[0-9;]*m//g"
  fi
}

stderr_print() {
  color_print "$@" >&2
}

warn() {
  stderr_print "$YELLOW$1"
}

error() {
  stderr_print "$RED$1"
  exit 1
}

info() {
  color_print "$CYAN$1"
}

ok() {
  color_print "$GREEN$1"
}

ssh_config() {
    # ssh config
    SSH_CONFIG_FILE=$HOME/.ssh/config

    if [ ! -d $SSH_DIR ]; then
        mkdir $HOME/.ssh
    elif [ ! -e $SSH_CONFIG_FILE ]; then
        cp -fv $HOME/dotfiles/.local/.ssh/config $HOME/.ssh/
        ok "ssh config file done succesfully"
    else
        warn "WARNING: ssh config file already exists, using existing file"
    fi
}

main() {
    ssh_config
}

main