#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${HOME}/.dotfiles/bkp"

items=(
  dotfiles-path
  bashrc
  profile
  bash_profile
  vimrc
  bundle
  asdfrc
  default-gems
  oh-my-zsh
  p10k.zsh
  zsh
  zshrc
  cargo
  gitconfig
  repo_.gitconfig.json
  aws-set-creds
  aws
  pydistutils.cfg
  pip
  npmrc
  bin
  local
)

for item in "${items[@]}"; do
  dst="${HOME}/.${item}"
  bkp="${BACKUP_DIR}/.${item}"

  [[ -e "${dst}" || -L "${dst}" ]] && {
    echo "Removing ${dst}"
    rm -rf "${dst}"
  }

  if [[ -e "${bkp}" || -L "${bkp}" ]]; then
    echo "Restoring ${bkp} -> ${dst}"
    cp -a "${bkp}" "${dst}"
  else
    echo "No backup found for ${item}"
  fi
done
