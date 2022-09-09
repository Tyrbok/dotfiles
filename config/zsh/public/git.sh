alias gaa="git add -A"
alias gc="git commit"
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch -a | grep -v remotes | fzf | xargs -I{} bash -c 'git checkout {}'"
alias gbl="git branch --all -vv"

alias gba="git branch -a | grep -v HEAD | grep remotes | fzf | cut -d'/' -f3- | xargs -I{} bash -c 'git switch {}'"
alias glt="git log --oneline --graph --decorate --all"
alias gl="git log --oneline --decorate --all"
alias glf="git log --oneline --decorate --first-parent"
alias gmc="git branch -a | grep -v remotes | fzf | xargs -I{} bash -c 'git merge-conflicts {}'"
alias gca='git commit -a'

gt() {
  _command="git for-each-ref --sort=-creatordate --format '%(refname) %(creatordate)' refs/tags | cut -d' ' -f1 | sed 's/refs\/tags\///g'"

  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]]; then
    eval "$_command"
  else
    eval "$_command" | head -n $1
  fi
}
