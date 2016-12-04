#!/bin/bash

function brew_install_lastpass_if_needed {
  lpass --help > /dev/null 2>&1
  local status=$?
  if [ $status -eq 127 ]; then
    echo "Lastpass not detected. Installing lastpass-cli using brew..."
    brew install lastpass-cli
    echo
  fi
}

function read_params {
  if [ "$#" -ne 2 ]; then
    echo "Usage: ec2ssh {username} {server nickname}"
    exit 1
  fi
  USERNAME=$1
  SERVERNAME=$2
}

read_params "$@"
brew_install_lastpass_if_needed

echo "SSHing to $2 as user $1..."


