export ZSH=$HOME/.oh-my-zsh

stty -ixon

ZSH_THEME="dst"
ZSH_CUSTOM=$HOME/.zsh/oh-my-zsh-custom

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

# here's LS_COLORS
# github.com/trapd00r/LS_COLORS
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
eval "$(gdircolors -b ~/.dircolors)"

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/keybindings.zsh
source $HOME/.zsh/path.zsh
source $HOME/.zsh/prompt.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Google Cloud
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# more mem for Maven
export MAVEN_OPTS="-Xmx1024m"

# Node
export NODE_OPTIONS=--max_old_space_size=8192

# TypeScript
export TSC_WATCHFILE="UseFsEventsWithFallbackDynamicPolling"

# Swift
export TOOLCHAINS=swift

# Android & Java
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Big Sur & Unix Tools
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

