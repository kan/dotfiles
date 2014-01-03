# kan's .zshrc

stty stop undef

bindkey -e

HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history
SHELL=/bin/zsh

fpath=($HOME/project/dotfiles/zsh/completions/src $fpath)

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
alias l='ls'
alias sl='ls'
alias la='ls -a'
alias ll='ls -l'
alias llh='ls -lh'
if [ -e '/usr/local/bin/gls' ]; then
    alias ls='\gls --color'
fi

setopt prompt_subst
autoload -Uz colors
colors

if [ "$TERM" = "dumb" ] ; then
    PROMPT='%h %n@%m[%d] %# '
    RPROMPT='%D %T'
else
    PROMPT=" %(?.%{${fg[green]}%}.%{${fg[red]}%})->  %{${fg[cyan]}%}%1~ %{${reset_color}%}"
fi

_set_env_git_current_branch() {
  GIT_CURRENT_BRANCH=$( git branch &> /dev/null | grep '^\*' | cut -b 3- )
}

_update_prompt () {
  if [ "`git ls-files 2>/dev/null`" ]; then
    PROMPT=" %(?.%{${fg[green]}%}.%{${fg[red]}%})-> %{${fg[cyan]}%}%1~ %{${fg[blue]}%}git:(%{${fg[yellow]}%}$GIT_CURRENT_BRANCH%{${fg[blue]}%}) %{${reset_color}%}"
  else
    PROMPT=" %(?.%{${fg[green]}%}.%{${fg[red]}%})-> %{${fg[cyan]}%}%1~ %{${reset_color}%}"
  fi
} 
  
precmd() 
{ 
  _set_env_git_current_branch
  _update_prompt
}

chpwd()
{
  _set_env_git_current_branch
  _update_prompt
}

alias   lv='w3m'
alias   less='w3m'
export  EDITOR=vim
alias   vi=vim

autoload bashcompinit
bashcompinit
source ~/project/dotfiles/zsh/git-comp.bash
if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
