#!/bin/zsh

autoload colors
colors

print -P "\n$fg[red]IMPORTANT: This action will replace current user configurations$reset_color\n"

read -q "REPLY?Press key 'y' to continue: "

if [[ "$REPLY" != "y" ]] ; then
  exit
fi

cd $HOME
PATH_ZSH_DOTFILES=$PWD/.dotfiles/config/zsh
PATH_GIT_DOTFILES=$PWD/.dotfiles/config/git
PATH_INSTALL_TEMPLATES=$PWD/.dotfiles/installer/_templates
PATH_INSTALL_STEPS=$PWD/.dotfiles/installer/_steps

function _link() {
  if [ -f $2 ]; then
    print -P "$fg[blue] - Remove file $2 ...$reset_color"
    rm "$2"
  fi

  print -P "$fg[white] - Link file $1 -> $2 ...$reset_color"
  ln -s $1 $2

}

print -P "\n$fg[green]Start Dotfiles Installer ...$reset_color\n"

for step in $(ls -1 $PATH_INSTALL_STEPS | sort -t'.' -n -k1); do
  source "$PATH_INSTALL_STEPS/$step"
done

unfunction _link

print -P "\n$fg[green]Done ... $fg[red] Restart your terminal for changes to take effect.$reset_color\n"
