if [[ ! -d /Applications/iTerm.app ]]; then
  print -P "$fg[yellow]* Installing iterm2... $reset_color"
  brew install iterm2
else
  print -P "$fg[white]* iterm2 is installed $reset_color"
fi

mkdir -p $PWD/.config/iterm2/AppSupport/
_link_path $PATH_ITERM_DOTFILES/Scripts $PWD/.config/iterm2/AppSupport/Scripts
