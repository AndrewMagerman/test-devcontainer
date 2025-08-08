#/usr/bin/env bash

set -euo pipefail

echo "🧠 Detecting platform..."
OS="$(uname -s)"
IS_WSL=false

if [[ "$OS" == "Linux" ]]; then
    if grep -qi microsoft /proc/version; then
        IS_WSL=true
        echo "✅ Running in WSL"
    else
        echo "✅ Running in Linux (likely Docker/devcontainer)"
    fi
elif [[ "$OS" == "Darwin" ]]; then
    echo "✅ Running on macOS"
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

# install_neovim() {
#     echo "📦 Installing Neovim (latest stable)..."
#     case "$OS" in
#         Darwin)
#             brew install neovim
#             ;;
#         Linux)
#             curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
#               | grep "browser_download_url.*nvim-linux64.tar.gz" \
#               | cut -d '"' -f 4 \
#               | xargs curl -Lo /tmp/nvim.tar.gz
#             sudo tar -C /usr/local --strip-components=1 -xzf /tmp/nvim.tar.gz nvim-linux64
#             rm /tmp/nvim.tar.gz
#             ;;
#     esac
# }

install_chezmoi() {
    echo "📦 Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
}

install_common_tools() {
    echo "📦 Installing common tools..."
    if [[ "$OS" == "Darwin" ]]; then
        brew install ripgrep fd fzf zsh
    else
        sudo apt-get update && sudo apt-get install -y \
            ripgrep fd-find fzf zsh unzip curl git jq
    fi
}

# macOS-only: install Homebrew if missing
if [[ "$OS" == "Darwin" && ! $(command -v brew) ]]; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

install_common_tools
# install_neovim
install_chezmoi

echo "🎯 Applying dotfiles from public repo..."
~/.local/bin/chezmoi init --apply AndrewMagerman 

echo "✅ Dotfiles applied."

if ! command -v fzf >/dev/null; then
  echo "📦 Installing fzf..."
  sudo apt-get update
  sudo apt-get install -y fzf
fi

echo "✅ Setup complete!"