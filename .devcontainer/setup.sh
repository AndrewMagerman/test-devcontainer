#!/usr/bin/env bash

set -euo pipefail

install_chezmoi() {
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
}

install_chezmoi
export PATH="$HOME/.local/bin:$PATH"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

~/.local/bin/chezmoi init --apply AndrewMagerman

if [[ -f "$HOME/.tmux.conf" && -x "$XDG_DATA_HOME/tmux/plugins/tpm/bin/install_plugins" ]]; then
    "$XDG_DATA_HOME/tmux/plugins/tpm/bin/install_plugins"
    tmux start-server
    tmux source-file "$HOME/.tmux.conf"
    tmux kill-server >/dev/null 2>&1 || true
fi
