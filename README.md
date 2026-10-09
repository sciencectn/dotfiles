# dotfiles


*Devs are tool-using animals. Without shell plugins they are nothing, with tons of shell plugins they are everything and also why is my prompt loading so slowly.* -Thomas Carlyle, probably. 

## Z shell

Works on macOS (requires [Homebrew](https://brew.sh)) and Ubuntu.
It *should* be idempotent.

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

Your oh-my-zsh plugins come from:
* Ubuntu: [plugins-ubuntu.txt](./plugins-ubuntu.txt)
* macOS: [plugins-mac.txt](./plugins-mac.txt)

This `setup.bash` manages `~/.zshrc`, so put your secret sauce into 
something like `~/.zshrc.d/local.zsh`. 
Anything in `~/.zshrc.d/*.zsh` gets sourced. 

Powerlevel10k runs `p10k configure` on first start to create `~/.p10k.zsh`.

## Ruby

I know I'm going to screw this up in the future so here's a note to my future self. 

You know how `conda` is nice? 
And you know how `homebrew` is annoying about installing newer Python or Ruby versions than the ones provided by macOS? 
Uses [rbenv](https://github.com/rbenv/rbenv) to manage your Ruby installations. 

Make sure to run `rbenv init` to set up your shell. 

## Windows

See [powershell-profile](https://github.com/sciencectn/powershell-profile) 
