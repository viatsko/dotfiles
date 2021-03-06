#!/usr/bin/env bash

brew tap dart-lang/dart

brew install dart \
  fzf \
  coreutils \
  moreutils \
  findutils \
  gnu-sed \
  nvm \
  pstree \
  openjdk \
  the_silver_searcher \
  ffmpeg \
  terminal-notifier

sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# buggy on M1
#brew install --cask homebrew/cask-drivers/logitech-g-hub

brew install --cask spotify \
  nova \
  karabiner-elements \
  telegram \
  figma \
  iterm2 \
  dropbox \
  discord \
  istat-menus \
  vlc \
  soundsource \
  homebrew/cask-versions/firefox-developer-edition \
  tor-browser \
  scroll-reverser \
  jetbrains-toolbox \
  google-chrome \
  visual-studio-code

# OpenJDK post-install
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >>~/.zshrc

brew cleanup
