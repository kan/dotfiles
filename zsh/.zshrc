# kan's .zshrc

stty stop undef

bindkey -e

HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history
SHELL=/usr/bin/zsh

autoload -U compinit
compinit

setopt autopushd print_eight_bit
setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
unsetopt promptcr
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

alias ls='\ls --color'
alias s='ls'
alias l='ls'
alias sl='ls'
alias la='ls -a'
alias ll='ls -l'
alias llh='ls -lh'
if [ -e '/usr/local/bin/gls' ]; then
    alias ls='\gls --color'
fi

setopt prompt_subst
if [ "$TERM" = "dumb" ] ; then
    PROMPT='%h %n@%m[%d] %# '
    RPROMPT='%D %T'
else
    PROMPT=$'%{\e[34m%}%U%B$HOST'"{`whoami`}%b%%%u "
    RPROMPT=$'%{\e[33m%}[%d] %D %T%{\e[m%}'
fi

_set_env_git_current_branch() {
  GIT_CURRENT_BRANCH=$( git branch &> /dev/null | grep '^\*' | cut -b 3- )
}

_update_rprompt () {
  if [ "`git ls-files 2>/dev/null`" ]; then
    RPROMPT=$'%{\e[33m%}[%~:$GIT_CURRENT_BRANCH] %D %T%{\e[m%}'
  else
    RPROMPT=$'%{\e[33m%}[%~] %D %T%{\e[m%}'
  fi
} 
  
precmd() 
{ 
  _set_env_git_current_branch
  _update_rprompt
}

chpwd()
{
  _set_env_git_current_branch
  _update_rprompt
}

alias   lv='w3m'
alias   less='w3m'
export  EDITOR=vim
alias   vi=vim

