plugin_path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

tmux source-file $plugin_path/plugin/mouse.conf
tmux source-file $plugin_path/plugin/vim.conf
tmux source-file $plugin_path/plugin/tmuxline.conf
tmux source-file $plugin_path/plugin/binds.conf
