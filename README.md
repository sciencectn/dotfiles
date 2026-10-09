# dotfiles


*Devs are tool-using animals. Without shell plugins they are nothing, with tons of shell plugins they are everything and also why is my prompt loading so slowly.* -Thomas Carlyle, probably. 

## Z shell

Works on macOS (requires [Homebrew](https://brew.sh)) and Ubuntu.

```
./setup.bash
```

This will:
* Install zsh and tmux (plus clipboard tools on Ubuntu)
* Install [oh-my-zsh](https://ohmyz.sh/#install)
* Install [autojump](https://github.com/wting/autojump)
* Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* Install [powerlevel 10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
* Install [fuzzy search finder](https://github.com/junegunn/fzf?tab=readme-ov-file#using-git)
* Copy `.tmux.conf` and, if your existing `~/.zshrc` is untouched, `.zshrc`

The oh-my-zsh plugin list is picked per OS from [plugins-mac.txt](./plugins-mac.txt)
or [plugins-ubuntu.txt](./plugins-ubuntu.txt) and written to `~/.zshrc.d/plugins.zsh`.
`~/.zshrc` sources every `~/.zshrc.d/*.zsh` before loading oh-my-zsh, so put
machine-specific config (PATH tweaks, secrets, aliases) in `~/.zshrc.d/local.zsh`
and it will survive re-running the script.

Powerlevel10k runs `p10k configure` on first start to create `~/.p10k.zsh`.

The script is safe to re-run; already-installed pieces are skipped.

## Ruby

I know I'm going to screw this up in the future so here's a note to my future self. 

You know how `conda` is nice? 
And you know how `homebrew` is annoying about installing newer Python or Ruby versions than the ones provided by macOS? 
Uses [rbenv](https://github.com/rbenv/rbenv) to manage your Ruby installations. 

Make sure to run `rbenv init` to set up your shell. 

## Windows

See [powershell-profile](https://github.com/sciencectn/powershell-profile) 
