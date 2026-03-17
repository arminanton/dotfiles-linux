#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${HOME}/.dotfiles/bkp"
SOURCE_DIR="${HOME}/.dotfiles/home"

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
  #local
)

mkdir -p "${BACKUP_DIR}"

for item in "${items[@]}"; do
  src="${SOURCE_DIR}/${item}"
  dst="${HOME}/.${item}"
  bkp="${BACKUP_DIR}/.${item}"

  [[ -e "${src}" || -L "${src}" ]] || {
    echo "Skipping ${item}: source not found (${src})"
    continue
  }

  if [[ -L "${dst}" && "$(readlink -f "${dst}")" == "$(readlink -f "${src}")" ]]; then
    echo "Already linked: ${dst}"
    continue
  fi

  if [[ -e "${dst}" || -L "${dst}" ]]; then
    echo "Backing up ${dst} -> ${bkp}"
    rm -rf "${bkp}"
    cp -a "${dst}" "${bkp}"
    rm -rf "${dst}"
  fi

  echo "Linking ${dst} -> ${src}"
  ln -s "${src}" "${dst}"
done
