#!/bin/bash
############################
# unlink.sh
# This script undo changes
############################
# check if there are other users using it

rm -f ~/.bash_profile ~/.bashrc ~/.vimrc ~/.bundle ~/.asdfrc ~/.default-gems &>/dev/null
cp -a ~/dotfiles/bkp/. ~/ &>/dev/null
