#!/bin/bash
############################
# link.sh
# This set up the files
############################

function dotfile_link() {
    mkdir -p "${HOME}/dotfiles/bkp" &>/dev/null
    cp -a "${HOME}/.${1}" "${HOME}/dotfiles/bkp/.${1}" &>/dev/null
    rm -Rf "${HOME}/.${1}"
    ln -s "${HOME}/dotfiles/home/${1}" "${HOME}/.${1}"
}

dotfile_link "bashrc"
dotfile_link "bash_profile"
dotfile_link "vimrc"
dotfile_link "bundle"
dotfile_link "asdfrc"
dotfile_link "default-gems"
