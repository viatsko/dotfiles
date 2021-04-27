ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

function host_color {
    case $HOST in
      devbox*) echo "$fg[red]" ;;
      *) echo "$fg[yellow]" ;;
    esac
}

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}
)
%{$fg[magenta]%}%n%{$reset_color%}@%{$(host_color)%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
$(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
