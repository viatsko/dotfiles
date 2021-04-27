# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

#
# Pager
#
export PAGER=less

# PATH isn't set yet (.zsh/path depends on this file), so we do the following
# instead of a simple `export EDITOR=$(which vim)`:
if [ -x "$HOME/bin/vim" ]; then
  export EDITOR=$HOME/bin/vim
else
  export EDITOR=vim
fi

case "$(uname)" in
Darwin*)
  if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
  fi
  ;;
Linux*)
  export JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64
  ;;
esac

# usually this means running on a machine with a statically-linked, hand-built
# tmux (and ncurses)
if [ -d "$HOME/.terminfo" ]; then
  export TERMINFO=$HOME/.terminfo
fi

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS=iFMRSX

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -iFMRSX"

# for the benefit of CPAN and potentially others
export FTP_PASSIVE=1

# colour ls listings
export CLICOLOR=true

#
# Go
#
export GOPATH=~/projects/go

#
# NodeJS
#
## Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

#
# Python
#
# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

#
# Homebrew
#
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#
# Atom Development
#
ATOM_REPOS_HOME=$HOME/projects
