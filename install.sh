set -e

if ! [ -n "$TMUX" ]; then
  echo -e "\033[31m✘ Must run in a tmux session to install!"
  exit 1
fi

echo -e "\033[32m➤ Installing!   \033[0m"

command -v git >/dev/null 2>&1 \
  && echo -e "\033[32m  ✔ Found         ❰ Git ❱   \033[0m" \
  || {
    echo -e "\033[31m  ✘ Missing       ❰ Git ❱   \033[0m"
    echo -e "\033[31m✘ Install failed!"
    exit 1
  }

if [ -d $HOME/.tmux/plugins/tpm ]; then
  echo -e "\033[32m  ✔ Found         ❰ tpm ❱   \033[0m"
else
  echo -e "  ➤ Installing    ❰ tpm ❱   \033[0m"

  command -v git >/dev/null 2>&1 && \
    env git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm >/dev/null 2>&1

  echo -e "\033[32m    ✔ Installed   ❰ tpm ❱   \033[0m"
fi

if [ -f $HOME/.tmux.conf ] || [ -h $HOME/.tmux.conf ]; then
  TMUXRC_LINE=$(head -n 1 $HOME/.tmux.conf);
  if [ "$TMUXRC_LINE" != '# rxrc/tmuxrc' ]; then
    echo -e "  ➤  Exists       ❰ ~/.tmux.conf ❱   \033[0m"

    mv $HOME/.tmux.conf $HOME/.tmux.conf.preinstall

    echo -e "\033[32m    ✔ Moved to    ❰ ~/.tmux.conf.preinstall ❱   \033[0m"
  else
    rm $HOME/.tmux.conf
  fi
fi

echo -e "  ➤ Installing    ❰ ~/.tmux.conf ❱   \033[0m"

tee $HOME/.tmux.conf >/dev/null <<EOF
# rxrc/tmuxrc

if-shell "test -f \$HOME/.tmux/plugins/tmuxrc/plugins.conf" "source \$HOME/.tmux/plugins/tmuxrc/plugins.conf"
if-shell "test ! -f \$HOME/.tmux/plugins/tmuxrc/plugins.conf" "set -g @tpm_plugins 'tmux-plugins/tpm rxrc/tmuxrc'"
run-shell '\$HOME/.tmux/plugins/tpm/tpm'
EOF

echo -e "\033[32m    ✔ Installed   ❰ ~/.tmux.conf ❱   \033[0m"

echo -e "  ➤ Run           ❰ Install Plugins ❱   \033[0m"

sh $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh &>/dev/null
sh $HOME/.tmux/plugins/tpm/scripts/update_plugin.sh all &>/dev/null
sh $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh &>/dev/null
sh $HOME/.tmux/plugins/tpm/scripts/update_plugin.sh all &>/dev/null

echo -e "\033[32m    ✔ Completed   ❰ Install Plugins ❱   \033[0m"

echo -e "\033[32m✔ Install complete!   \033[0m"

exit 0
