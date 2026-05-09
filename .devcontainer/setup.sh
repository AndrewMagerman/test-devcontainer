#!/usr/bin/env bash

set -euo pipefail

install_chezmoi() {
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
}

install_chezmoi
export PATH="$HOME/.local/bin:$PATH"

~/.local/bin/chezmoi init --apply AndrewMagerman 
