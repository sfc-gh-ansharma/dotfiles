#!/bin/bash

INSTALL_HOMEBREW=${INSTALL_HOMEBREW:-0}

mkdir -p $HOME/.local/bin

# Install homebrew and some required packages
if [[ $INSTALL_HOMEBREW -eq 1 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

brew install zsh neovim ripgrep fzf rust lazygit tree btop bat git-delta fd tlrc starship

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install NVM and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

# Install some more packages
cargo install --locked tree-sitter-cli eza

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
