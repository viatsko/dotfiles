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

source $HOME/.zsh/prompt.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# more mem for Maven
export MAVEN_OPTS="-Xmx1024m"

export NODE_OPTIONS=--max_old_space_size=8192
export TSC_WATCHFILE="UseFsEventsWithFallbackDynamicPolling"
export TOOLCHAINS=swift

export ANDROID_HOME=$HOME/Library/Android/sdk

