#!/usr/bin/env bash

set -e

# TODO switch to brew if on macos, and only install necessary dependencies
# brew is a required dependency, fail if not installed
sudo apt -y install \
    autojump \
    curl \
    git \
    tmux \
    xclip \
    xsel \
    zsh

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

# Fuzzy search finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Power level 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Copy tmux conf
cp .tmux.conf ~/.tmux.conf

# TODO copy .zshrc but only if it appears there is a vanilla zshrc that this script hasn't touched yet
# consider using .d directories
