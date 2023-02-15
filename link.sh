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

IFS=" "

function dotfile_loop() {
    local items
    items="bashrc bash_profile vimrc bundle asdfrc default-gems oh-my-zsh"
    items+=" p10k.zsh zsh zshrc"

    for item in $items; do
        dotfile_link "$item"
    done
}

dotfile_loop
