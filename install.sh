main () {
  set -e

  if ! [ -n "$TMUX" ]; then
    echo -e "\033[31m✘ Must run in a tmux session to install!"
    exit 1
  fi

  set -u

  repo='rxrc/tmuxrc'

  tmuxhome="${TMUX_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/tmux}"
  install_tmuxrc
}

install_tmuxrc () {
  echo -e "\033[32m➤ Installing!   \033[0m"

  command -v git >/dev/null 2>&1 \
    && echo -e "\033[32m  ✔ Found         ❰ Git ❱   \033[0m" \
    || {
      echo -e "\033[31m  ✘ Missing       ❰ Git ❱   \033[0m"
      echo -e "\033[31m✘ Install failed!"
      exit 1
    }

  if [ -d $tmuxhome/plugins/tpm ]; then
    echo -e "\033[32m  ✔ Found         ❰ tpm ❱   \033[0m"
  else
    echo -e "  ➤ Installing    ❰ tpm ❱   \033[0m"

    command -v git >/dev/null 2>&1 && \
      env git clone https://github.com/tmux-plugins/tpm.git $tmuxhome/plugins/tpm >/dev/null 2>&1

    echo -e "\033[32m    ✔ Installed   ❰ tpm ❱   \033[0m"
  fi

  if [ -f $tmuxhome/tmux.conf ] || [ -h $tmuxhome/tmux.conf ]; then
    TMUXRC_LINE=$(head -n 1 $tmuxhome/tmux.conf);
    if [ "$TMUXRC_LINE" != "# $repo" ]; then
      echo -e "  ➤  Exists       ❰ $tmuxhome/tmux.conf ❱   \033[0m"

      mv $tmuxhome/tmux.conf $tmuxhome/tmux.conf.preinstall

      echo -e "\033[32m    ✔ Moved to    ❰ $tmuxhome/tmux.conf.preinstall ❱   \033[0m"
    else
      rm $tmuxhome/tmux.conf
    fi
  fi

  echo -e "  ➤ Installing    ❰ $tmuxhome/tmux.conf ❱   \033[0m"

  tee $tmuxhome/tmux.conf >/dev/null <<EOF
# $repo

if-shell "test -f $tmuxhome/plugins/tmuxrc/plugins.conf" "source $tmuxhome/plugins/tmuxrc/plugins.conf"
if-shell "test ! -f $tmuxhome/plugins/tmuxrc/plugins.conf" "set -g @tpm_plugins 'tmux-plugins/tpm $repo'"
run-shell '$tmuxhome/plugins/tpm/tpm'
EOF

  echo -e "\033[32m    ✔ Installed   ❰ $tmuxhome/tmux.conf ❱   \033[0m"

  echo -e "  ➤ Run           ❰ Install Plugins ❱   \033[0m"

  sh $tmuxhome/plugins/tpm/bin/install_plugins &>/dev/null
  sh $tmuxhome/plugins/tpm/bin/install_plugins &>/dev/null

  echo -e "\033[32m    ✔ Completed   ❰ Install Plugins ❱   \033[0m"

  echo -e "\033[32m✔ Install complete!   \033[0m"

  exit 0
}

main
