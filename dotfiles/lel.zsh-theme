function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%{$fg_bold[blue]%}[%m%]{$reset_color%} %(!.%{$fg_bold[red]%}%n.%{$fg_bold[green]%}%n) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%? %_$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
