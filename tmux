# prefixをCtrl+tに
unbind C-b
set -g prefix C-t
bind C-t send-prefix

# rで設定の再読み込み
unbind r
bind r source-file ~/.tmux.conf

unbind k
bind k kill-window

unbind C-v
bind C-v copy-mode

bind -t vi-copy v begin-selection

unbind C-t
bind C-t last-window

unbind |
bind | split-window -h

unbind -
bind - split-window -v

set-option -g history-limit 10000
set-option -g status-utf8 on
set-option -g status-interval 5
set-window-option -g mode-mouse on

set-option -g set-titles on
set-option -g set-titles-string "@#(hostname | sed 's/\\\\..*//')"

set-option -g status-bg white
set-option -g status-fg black
set-option -g status-attr dim
# prompt left
set-option -g status-left-length 100
set -g status-left '#[fg=colour26,bold][#20(whoami)@#H](#S)#[default]'
# prompt right
set-option -g status-right-length 50
set -g status-right '#[fg=black,bold]%Y/%m/%d(%a) %H:%M#[default]'

set-window-option -g window-status-current-bg colour26
set-window-option -g window-status-current-fg white
set-window-option -g window-status-current-attr bold

set-window-option -g mode-key vi
source-file ~/.tmux.conf.local
