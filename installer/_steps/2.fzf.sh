if ! type "fzf" > /dev/null; then
  print -P "$fg[yellow]* Installing fzf... $reset_color"
  brew install fzf
else
  print -P "$fg[white]* FZF is installed $reset_color"
fi
