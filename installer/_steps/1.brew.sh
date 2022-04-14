######
# BREW
######
if ! type "brew" > /dev/null; then
    print -P "$fg[yellow]* Installing Homebrew... $reset_color"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    print -P "$fg[white]* Homebrew is installed $reset_color"
fi
