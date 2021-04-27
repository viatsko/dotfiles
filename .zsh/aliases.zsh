###
# time to upgrade `ls`

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color >/dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls='gls -AFh ${colorflag} --group-directories-first'
alias lsd='ls -l | grep "^d"' # only directories
#    `la` defined in .functions
###

alias vim=vi
