set -e

if ! [ -n "$TMUX" ]; then
  echo -e "\033[31m✘ Must run in a tmux session to install!"
  exit 1
fi

echo -e "\033[32m➤ Installing!   \033[0m"

hash git >/dev/null 2>&1 \
  && echo -e "\033[32m  ✔ Found         ❰ Git ❱   \033[0m" \
  || {
    echo -e "\033[31m  ✘ Missing       ❰ Git ❱   \033[0m"
    echo -e "\033[31m✘ Install failed!"
    exit 1
  }

if [ -d ~/.tmux/plugins/tpm ]; then
  echo -e "\033[32m  ✔ Found         ❰ tpm ❱   \033[0m"
else
  echo -e "  ➤ Installing    ❰ tpm ❱   \033[0m"

  hash git >/dev/null 2>&1 && \
    env git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm >/dev/null 2>&1

  echo -e "\033[32m    ✔ Installed   ❰ tpm ❱   \033[0m"
fi

if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
  TMUXRC_LINE=$(head -n 1 ~/.tmux.conf);
  if [ "$TMUXRC_LINE" != '# razor-x/tmuxrc' ]; then
    echo -e "  ➤  Exists       ❰ ~/.tmux.conf ❱   \033[0m"

    mv ~/.tmux.conf ~/.tmux.conf.preinstall

    echo -e "\033[32m    ✔ Moved to    ❰ ~/.tmux.conf.preinstall ❱   \033[0m"
  else
    rm ~/.tmux.conf
  fi
fi

echo -e "  ➤ Installing    ❰ ~/.tmux.conf ❱   \033[0m"

tee ~/.tmux.conf >/dev/null <<EOF
# razor-x/tmuxrc

if-shell "test -f ~/.tmux/plugins/tmuxrc/plugins.conf" "source ~/.tmux/plugins/tmuxrc/plugins.conf"

if-shell "test ! -f ~/.tmux/plugins/tmuxrc/plugins.conf" "set -g @tpm_plugins 'tmux-plugins/tpm razor-x/tmuxrc'"

run-shell '~/.tmux/plugins/tpm/tpm'
EOF

echo -e "\033[32m    ✔ Installed   ❰ ~/.tmux.conf ❱   \033[0m"

echo -e "  ➤ Run           ❰ Install Plugins ❱   \033[0m"

sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh &>/dev/null
sh ~/.tmux/plugins/tpm/scripts/update_plugin.sh all &>/dev/null
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh &>/dev/null
sh ~/.tmux/plugins/tpm/scripts/update_plugin.sh all &>/dev/null

echo -e "\033[32m    ✔ Completed   ❰ Install Plugins ❱   \033[0m"

echo -e "\033[32m✔ Install complete!   \033[0m"

exit 0
