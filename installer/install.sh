#!/bin/zsh

autoload colors
colors
echo
print -P "$fg[green]======================$reset_color"
print -P "$fg[green]|                    |$reset_color"
print -P "$fg[green]| Dotfiles Installer |$reset_color"
print -P "$fg[green]|                    |$reset_color"
print -P "$fg[green]======================$reset_color"
echo

command_exists() {
  type "$1" >/dev/null 2>&1
}

_w() {
  local -r text="${1:-}"
  echo -e "$text"
}
_a() { _w "* $1"; }
_e() { _a "${red}$1${normal}"; }
_s() { _a "${green}$1${normal}"; }
_q() { read -q "🤔 $1: " "$2"; }

install_git() {
  case "$OSTYPE" in
    darwin*)
      _a "Checking if Command Line Tools are installed 🕵️‍️"

      xcode-select --install 2>&1 | grep installed >/dev/null
      if [[ $? ]]; then
        _a "Installing Command Line Tools 📺"
        xcode-select --install
        _q "Press a key after command line tools has finished to continue...👇" "CLT_INSTALLED"
      fi
      ;;
    *)
      _e "Could not install git, no package provider found"
      exit 1
      ;;
  esac
}

print -P "\n$fg[red]IMPORTANT:$reset_color This action will replace current user configurations\n"

read -q "REPLY?🤔 Press key 'y' to continue: "

if [[ "$REPLY" != "y" ]] ; then
  exit
fi

cd $HOME

PATH_DOTFILES="$HOME/.dotfiles"
if [ -d "$PATH_DOTFILES" ]; then
  print -P "\n\n$fg[red]* Backup and remove old .dotfiles $reset_color"
  rnd=$(echo $RANDOM | md5sum | head -c 20; echo;)
  copy_of_dotfile="${PATH_DOTFILES}_$rnd"
  print -P "$fg[red] - $copy_of_dotfile $reset_color"
  mv $PATH_DOTFILES $copy_of_dotfile
  echo
fi

if ! command_exists git; then
  _e "git not installed, trying to install"
  install_git
fi

_a "Downloading git"
git clone https://github.com/Tyrbok/dotfiles.git .dotfiles
source .dotfiles/installer/restore.sh
echo
echo
_a "🎉 .dotfiles installed correctly! 🎉"
_a "Please, restart your terminal to see the changes"
