print -P "$fg[yellow]* Installing Raycast config...$reset_color"

if [ ! -d /Applications/Raycast.app ]; then
  brew install --cask raycast
else
  print -P "$fg[magenta] - Raycast app already exists...$reset_color"
fi

if [[ -d "$PWD/.config/raycast" || -L "$PWD/.config/raycast" ]]; then
  print -P "$fg[magenta] - Replace old Raycast config...$reset_color"
  rm -rf $PWD/.config/raycast
fi

_link $PATH_RAYCAST_DOTFILES/ $PWD/.config/raycast