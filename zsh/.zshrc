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

fpath=($fpath "$HOME/.zsh/prompt")
autoload -Uz promptinit
promptinit
prompt "${ZSH_THEME:-"kan"}"

setopt prompt_subst
autoload -Uz colors
colors

autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 2
zstyle ':vcs_info:*' enable git hg

zstyle ':vcs_info:*' formats "%F{blue}%s:(%F{yellow}%b%F{blue})"

# history of cd
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# for peco
function peco_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        peco | xargs echo
}

function peco-select-history()
{
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tac -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history

function peco-cd()
{
    local destination=$(peco_get_destination_from_history)
    [ -n $destination ] && cd ${destination/#\~/${HOME}}
    zle reset-prompt
}
zle -N peco-cd

function peco-src()
{
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src

function peco-git-vim()
{
    local selected_file=$(git status -s | cut -d' ' -f3 | peco --query "$LBUFFER")
    if [ -n "$selected_file" ]; then
        BUFFER="vim ${selected_file}"
    fi
    zle clear-screen
}
zle -N peco-git-vim

bindkey '^r' peco-select-history
bindkey '^x' peco-cd
bindkey '^k' peco-src
bindkey '^s' peco-git-vim
alias pcd=peco-cd

function agp()
{
    if $2; then
        vim $(ag -l $1 $2 | peco)
    else
        vim $(ag -l $1 . | peco)
    fi
}

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

if ! zplug check; then
    zplug install
fi

zplug "zplug/zplug"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-autosuggestions"

if zplug check b4b4r07/enhancd; then
    export ENHANCD_FILTER=peco
fi

zplug load

