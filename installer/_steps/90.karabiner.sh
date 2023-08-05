print -P "$fg[yellow]* Copy Karabiner dotfiles...$reset_color"
if [ -f "$PWD/.config/karabiner.edn" ]; then
  print -P "$fg[red] - Karabiner config already exists (skip)...$reset_color"
else
  mkdir -p $PWD/.config
  _link $PATH_KARABINER_DOTFILES/karabiner.edn $PWD/.config/karabiner.edn
  _link $PATH_KARABINER_DOTFILES/karabiner $PWD/.config/karabiner
fi
