#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $DIR

rm -f $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $DIR/Code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

rm -f $HOME/Library/Application\ Support/Code/User/keybindings.json
ln -s $DIR/Code/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

rm -rf $HOME/Library/Application\ Support/Code/User/snippets
ln -s $DIR/Code/snippets/ $HOME/Library/Application\ Support/Code/User

pkglist=( $(cat $DIR/vscode-extensions.txt | tr '\n' ' ') )

for i in ${pkglist[@]}; do
  code --install-extension $i
done
