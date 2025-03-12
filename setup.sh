#!/bin/bash

INSTALL_HOMEBREW=${INSTALL_HOMEBREW:-0}

HOME_BIN=$HOME/.local/bin
mkdir -p $HOME_BIN

GO=$(which go)
if [[ $? -eq 1 ]]; then
	GO=/usr/local/bin/go
fi

if [[ $(uname) == "Darwin" ]]; then
	if [[ $INSTALL_HOMEBREW -eq 1 ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew install zsh neovim ripgrep
fi

# Install latest FZF
rm -rf ${HOME}/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-zsh --no-fish
ln -s ~/.fzf/bin/fzf ${HOME_BIN}/fzf

# Install cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y
. "${HOME}/.cargo/env"

# Install oh-my-zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install NVM and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install v16.20.2

# Install lazygit
rm -rf v0.44.1.tar.gz lazygit-0.44.1
wget https://github.com/jesseduffield/lazygit/archive/refs/tags/v0.44.1.tar.gz
tar -xvf v0.44.1.tar.gz
cd lazygit-0.44.1
$GO install
cd .. && rm -rf lazygit-0.44.1 v0.44.1.tar.gz

if [[ $(usname) != "Darwin" ]]; then
	# Install btop
	rm -rf btop-aarch64-linux-musl.tbz
	wget https://github.com/aristocratos/btop/releases/download/v1.4.0/btop-aarch64-linux-musl.tbz
	tar -xvf btop-aarch64-linux-musl.tbz
	cd btop
	sudo make install
	cd .. && rm -rf btop btop-aarch64-linux-musl.tbz
fi

# Install some more packages
cargo install --locked tree-sitter-cli eza bat git-delta fd-find zoxide
npm install -g tldr

# Install starship
curl -sS https://starship.rs/install.sh | sh

rm -rf $HOME/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Initialize bat theme
$HOME/.cargo/bin/bat cache --build
