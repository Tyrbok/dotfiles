print -P "$fg[yellow]* Replace git dotfiles...$reset_color"

if [ ! -f $PATH_GIT_DOTFILES/.gitconfig ]; then
  cp $PATH_INSTALL_TEMPLATES/gitconfig $PATH_GIT_DOTFILES/.gitconfig
fi

_link $PATH_GIT_DOTFILES/.gitignore_global $PWD/.gitignore_global
_link $PATH_GIT_DOTFILES/.gitconfig $PWD/.gitconfig

