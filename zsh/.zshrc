# kan's .zshrc

stty stop undef

bindkey -e

HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history
SHELL=/bin/zsh

fpath=(/Users/kan/src/github.com/kan/dotfiles/zsh/m-cli/completion/zsh $fpath)

autoload -Uz compinit
compinit -C

setopt autopushd print_eight_bit
setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt NO_beep append_history share_history magic_equal_subst
unsetopt promptcr
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*' verbose no
zstyle ':completion:*' completer _complete _ignored # default: _complete _ignored
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
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

autoload -Uz colors
colors

alias   lv='w3m'
alias   less='w3m'
export  EDITOR=vim
alias   vi=vim

autoload bashcompinit
bashcompinit

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

source $HOME/src/github.com/kan/dotfiles/zsh/git-comp.bash

source $HOME/src/github.com/kan/dotfiles/zsh/zplug/init.zsh

zplug "zplug/zplug"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/anyframe"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

zplug check || zplug install

if zplug check b4b4r07/enhancd; then
    export ENHANCD_FILTER=peco
fi

zplug load

function anyframe-widget-ghq () {
    ghq list \
        | anyframe-selector-auto \
        | anyframe-action-execute ghq look
}
zle -N anyframe-widget-ghq

bindkey '^w' anyframe-widget-select-widget
bindkey '^r' anyframe-widget-put-history
bindkey '^k' anyframe-widget-ghq
bindkey '^x' anyframe-widget-kill

