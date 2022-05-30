#!/bin/bash

# import for text colors
source colors.sh

# fail on error and report it, debug all lines
# https://askubuntu.com/a/956410
set -eu -o pipefail

# run as a superuser and do not ask for a password.
# exit status as successful.
# sudo -n true
# test $? -eq 0 || exit 1 "sudo privileges required to run this script"

# install fish shell
if ! command -v fish &> /dev/null
then
  echo -e "installing ${IBlue}fish${NC}\n"
  apt install fish
else
  echo -e "\n${IBlue}fish${NC} already installed"
fi

# install exa
if ! command -v exa &> /dev/null
then
  echo -e "installing ${IBlue}exa${NC}\n"
  apt install exa
else
  echo -e "\n${IBlue}exa${NC} already installed"
fi

# install peco
if ! command -v peco &> /dev/null
then
  echo -e "installing ${IBlue}peco${NC}\n"
  apt install peco
else
  echo -e "\n${IBlue}peco${NC} already installed"
fi

# remove sudo, so fisher doesn't use root during installs
sudo -k

# install fisher
if [[ $(fish -c "fisher") ]]; then
  echo -e "\n${IBlue}fisher${NC} already installed"
else
  echo -e "\nno ${IBlue}fisher${NC} installed"
  echo -e "installing ${IBlue}fisher${NC}"
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
        | source && fisher install jorgebucaran/fisher"
fi

# install tide
if [[ $(fish -c "fisher list" | grep tide | wc -c) -gt 0 ]]; then
  echo -e "\n${IBlue}tide${NC} already installed"
else
  echo -e "\nno ${IBlue}tide${NC} installed"
  echo -e "installing ${IBlue}tide${NC}"
  fish -C "fisher install IlanCosman/tide@v5; exit;" 
fi

# Y 3 1 2 1 1 1 2 1 3 3 2 2 Y

# install nerd fonts
# echo -e "\ninstalling nerd fonts"
# mkdir -p ~/.local/share/fonts

# install z
if [[ $(fish -c "fisher list" | grep jethrokuan | wc -c) -gt 0 ]]; then
  echo -e "\n${IBlue}z${NC} already installed"
else
  echo -e "\nno ${IBlue}z${NC} installed"
  echo -e "installing ${IBlue}z${NC}"
  fish -C "fisher install jethrokuan/z; exit;"
fi