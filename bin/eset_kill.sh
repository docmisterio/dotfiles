#!/bin/bash

RESET_COLOR="\033[0m"
BRIGHT_RED="\033[91m"
BRIGHT_GREEN="\033[92m"

echo "This script will kill the eset virus scanner program. You must have root."
echo "Press 'Y' to continue..."
read -n 1 -r -s menuChoice

function kill_eset {
  echo "Killing eset virus scanner..."
  sudo kill `pgrep eset`
  if [ $? -ne 0 ]; then
    echo -e "${BRIGHT_RED}Failed to kill some processes!${RESET_COLOR}"
    exit 1
  else
    echo -e "${BRIGHT_GREEN}Killed it!${RESET_COLOR}"
  fi
}

case $menuChoice in
  [yY])
  kill_eset
  ;;
  *)
    echo -e "canceled..."
  exit
esac
