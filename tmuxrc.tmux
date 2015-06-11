plugin_path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

tmux source-file $plugin_path/plugin/tmuxline.conf
