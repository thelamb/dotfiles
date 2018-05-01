#!/bin/bash

DOTFILES_PATH='/home/chris/dev/dotfiles'
HOME_PATH='/home/chris'

declare -A links=(
    # vim
    [${DOTFILES_PATH}/vim]=${HOME_PATH}/.vim
    [${DOTFILES_PATH}/vim/init.vim]=${HOME_PATH}/.vimrc

    # tmux
    [${DOTFILES_PATH}/config/tmux.conf]=${HOME_PATH}/.tmux.conf

    # bashrc
    [${DOTFILES_PATH}/config/bashrc.conf]=${HOME_PATH}/.bashrc.conf
)

for i in "${!links[@]}"; do
    if [ ! -L ${links[$i]} ]; then
        echo "Creating ${links[$i]}"
        ln -s $i ${links[$i]}
    fi
done

