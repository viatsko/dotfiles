#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until setup has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# As some files might have been committed from cygwin, ensure exec-bit
chmod +x *.sh

# Run step-by-step scripts to set the machine up
. _dock_cleanup.sh
. _brew_update_or_install.sh
. _brew_install_apps.sh
. _git_submodules.sh
. _osx.sh
. _symlinks_setup.sh
. _zsh_fix.sh

