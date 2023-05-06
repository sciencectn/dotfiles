# dotfiles

Installation
* Install zsh
* Install [oh-my-zsh](https://ohmyz.sh/#install)
* Install [autojump](https://github.com/wting/autojump)
* Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* Install [powerlevel 10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
* Install [fuzzy search finder](https://github.com/junegunn/fzf#using-linux-package-managers)

Then adapt the [.zshrc](.zshrc) to your system. 
Ideally, follow the instructions for each plugin and much of the `.zshrc` will create itself. 

e.g. this line 
`[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh`
comes from the fzf installer. 




## Ruby

I know I'm going to screw this up in the future so here's a note to my future self. 

You know how `conda` is nice? 
And you know how `homebrew` is annoying about installing newer Python or Ruby versions than the ones provided by macOS? 
Uses [rbenv](https://github.com/rbenv/rbenv) to manage your Ruby installations. 

Make sure to run `rbenv init` to set up your shell. 


