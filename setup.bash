#!/usr/bin/env bash

set -euo pipefail

# Run from the repo directory so relative copies work from anywhere
cd "$(dirname "${BASH_SOURCE[0]}")"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ---------------------------------------------------------------------------
# OS detection and package install
# ---------------------------------------------------------------------------
case "$(uname -s)" in
    Darwin)
        DOTFILES_OS=mac
        if ! command -v brew >/dev/null 2>&1; then
            echo "error: Homebrew is required on macOS. Install it from https://brew.sh and re-run." >&2
            exit 1
        fi
        # git, curl, and zsh ship with macOS / Xcode command line tools.
        # Clipboard uses pbcopy, so no xclip/xsel.
        brew install autojump tmux
        ;;
    Linux)
        DOTFILES_OS=ubuntu
        sudo apt -y install \
            autojump \
            curl \
            git \
            tmux \
            xclip \
            xsel \
            zsh
        ;;
    *)
        echo "error: unsupported OS: $(uname -s)" >&2
        exit 1
        ;;
esac

# ---------------------------------------------------------------------------
# Shell tooling (each step skips itself if already installed)
# ---------------------------------------------------------------------------

# Oh my zsh. --unattended: don't chsh or exec zsh mid-script.
# --keep-zshrc: never replace an existing ~/.zshrc; we handle that below.
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh already installed, skipping"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# zsh autosuggestions
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestions already installed, skipping"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Fuzzy search finder. ~/.zshrc sources ~/.fzf.zsh itself, so don't let the
# installer edit rc files.
if [ -d "$HOME/.fzf" ]; then
    echo "fzf already installed, skipping"
else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
fi
"$HOME/.fzf/install" --all --no-update-rc

# Power level 10k. No .p10k.zsh is shipped; p10k runs its configure wizard
# on first interactive start when ~/.p10k.zsh is missing.
if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "powerlevel10k already installed, skipping"
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ---------------------------------------------------------------------------
# Config files
# ---------------------------------------------------------------------------

# tmux: single conf, picks pbcopy or xsel at runtime via if-shell
cp .tmux.conf "$HOME/.tmux.conf"

# Per-OS oh-my-zsh plugin list. ~/.zshrc sources everything in ~/.zshrc.d/
# before loading oh-my-zsh. plugins.zsh is owned by this script and always
# overwritten; put machine-local config in other files there (e.g. local.zsh).
mkdir -p "$HOME/.zshrc.d"
cp "plugins-${DOTFILES_OS}.txt" "$HOME/.zshrc.d/plugins.zsh"

if [[ "${DOTFILES_OS}" == "mac" ]]; then
    cp -v sublime-mac.zsh "$HOME/.zshrc.d/"
fi

# ~/.zshrc: only install ours if the existing one is "vanilla", i.e. missing,
# already ours (marker line), or the untouched oh-my-zsh template.
ZSHRC_MARKER='# Managed by sciencectn/dotfiles'
OMZ_TEMPLATE="$HOME/.oh-my-zsh/templates/zshrc.zsh-template"

is_vanilla_zshrc() {
    [ ! -f "$HOME/.zshrc" ] && return 0
    grep -qF "$ZSHRC_MARKER" "$HOME/.zshrc" && return 0
    if [ -f "$OMZ_TEMPLATE" ]; then
        # The installer only rewrites the `export ZSH=` line of the template.
        diff -q <(grep -v '^export ZSH=' "$HOME/.zshrc") \
                <(grep -v '^export ZSH=' "$OMZ_TEMPLATE") >/dev/null 2>&1 && return 0
    fi
    return 1
}

if is_vanilla_zshrc; then
    cp .zshrc "$HOME/.zshrc"
    echo "installed ~/.zshrc"
else
    cat <<MSG
~/.zshrc has local customizations, so it was left untouched.
To switch to the dotfiles version:
  1. move your machine-specific config (PATH tweaks, secrets, aliases, ...)
     into ~/.zshrc.d/local.zsh
  2. cp $(pwd)/.zshrc ~/.zshrc   (or re-run this script after deleting ~/.zshrc)
The plugins=(...) list is now provided by ~/.zshrc.d/plugins.zsh.
MSG
fi

# ---------------------------------------------------------------------------
# Default shell
# ---------------------------------------------------------------------------
case "${SHELL:-}" in
    */zsh) ;;
    *)
        chsh -s "$(command -v zsh)" || echo "warning: could not change default shell to zsh; run 'chsh -s $(command -v zsh)' yourself"
        ;;
esac

echo "done. Start a new shell (or run: exec zsh) to pick up the changes."
