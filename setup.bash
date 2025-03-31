#!/usr/bin/env bash

set -e

PATH_TO_ZSHRC=$(realpath "$(dirname "$0")"/.zshrc)

if ! [[ -f "$PATH_TO_ZSHRC" ]]; then
    echo "Bad path to zshrc file which we need to source: $PATH_TO_ZSHRC"
    exit 1
fi

add_source_to_rc() {
    {
        echo "# >>> zsh setup script >>>"
        echo "source '$PATH_TO_ZSHRC'" 
        echo "# <<< zsh setup script <<<" 
    } >> "${HOME}/.zshrc"
}

sudo apt -y install zsh

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# autojump
sudo apt -y install autojump

# zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Fuzzy search finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Power level 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if ! grep --quiet ">>> zsh setup script >>>" "${HOME}/.zshrc" &> /dev/null; then
    add_source_to_rc
fi

