#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

declare -a files=(
	.dircolors
        .oh-my-zsh
	.vim
	.zsh
        .zshrc
)

for file in "${files[@]}"; do
        if [ ! -f ~/$file ] && [ ! -d ~/$file ]; then
                echo "Creating symlink to $file in home directory."
                ln -s $DIR/$file ~/$file
        fi
done

