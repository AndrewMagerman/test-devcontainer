#!/bin/bash
set -euxo pipefail

echo "📦 Installing chezmoi..."

curl -sfL https://git.io/chezmoi | sh -s -- -b ~/.local/bin

echo "🎯 Applying dotfiles from public repo..."
~/.local/bin/chezmoi init --apply https://github.com/AndrewMagerman/.dotfiles.git

echo "✅ Dotfiles applied."

if ! command -v fzf >/dev/null; then
  echo "📦 Installing fzf..."
  sudo apt-get update
  sudo apt-get install -y fzf
fi
