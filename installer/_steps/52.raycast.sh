print -P "$fg[yellow]* Installing raycast config...$reset_color"

if [ ! -d /Applications/Warp.app ]; then
  brew install --cask warp
else
  print -P "$fg[magenta] - Warp app already exists...$reset_color"
fi

if [ -d "$PWD/.warp" ]; then
  print -P "$fg[magenta] - Replace old .warp config...$reset_color"
  rm -rf $PWD/.warp
fi

_link $PATH_WARP_DOTFILES/warp $PWD/.warp