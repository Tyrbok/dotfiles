print -P "$fg[yellow]* Replace zsh dotfiles...$reset_color"

_link $PATH_ZSH_DOTFILES/.zshrc $PWD/.zshrc
_link $PATH_ZSH_DOTFILES/.zimrc $PWD/.zimrc
_link $PATH_ZSH_DOTFILES/.zlogin $PWD/.zlogin
_link $PATH_ZSH_DOTFILES/.fzf.zsh $PWD/.fzf.zsh
