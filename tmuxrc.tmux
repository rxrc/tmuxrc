set -g default-terminal 'screen-256color'

if-shell "test -f ~/.tmuxline.conf" "source ~/.tmuxline.conf"
