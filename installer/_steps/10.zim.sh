fname=$(declare -f -F zimfw)

if [ -n "$fname" ] ; then
  print -P "$fg[yellow]* Installing ZIM... $reset_color"
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    print -P "$fg[white]* ZIM is installed $reset_color"

fi
