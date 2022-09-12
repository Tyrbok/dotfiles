print -P "$fg[yellow]* Copy Karabiner dotfiles...$reset_color"

mkdir -p $PWD/.config
_link $PATH_KARABINER_DOTFILES/karabiner.edn $PWD/.config/karabiner.edn
_link $PATH_KARABINER_DOTFILES/karabiner $PWD/.config/karabiner
