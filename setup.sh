#!/bin/bash

INSTALL_HOMEBREW=${INSTALL_HOMEBREW:-0}

mkdir -p $HOME/.local/bin

if [[ $(uname) == "Darwin" ]]; then
	if [[ $INSTALL_HOMEBREW -eq 1 ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew install zsh neovim ripgrep
fi

# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

# Install latest FZF
rm -rf ${HOME}/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-zsh --no-fish
ln -s ~/.fzf/bin/fzf ${HOME_BIN}/fzf

# Install cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y
. "${HOME}/.cargo/env"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install NVM and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

# Install lazygit
wget https://github.com/jesseduffield/lazygit/archive/refs/tags/v0.44.1.tar.gz
tar -xvf v0.44.1.tar.gz
cd lazygit-0.44.1
go install

# Install btop
wget https://github.com/aristocratos/btop/releases/download/v1.4.0/btop-aarch64-linux-musl.tbz
tar -xvf btop-aarch64-linux-musl.tbz
cd btop-aarch64-linux-musl
sudo make install

# Install some more packages
cargo install --locked tree-sitter-cli eza bat git-delta fd-find
npm install -g tldr

# Install starship
curl -sS https://starship.rs/install.sh | sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
