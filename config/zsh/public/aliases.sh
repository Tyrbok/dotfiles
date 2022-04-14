alias sudo="sudo "
alias ..="cd .."
alias ...="cd ../.."
alias ll="exa -l"
alias la="exa -la"

alias ls=exa
alias l='ls -lah --icons'

alias gaa="git add -A"
alias gc="git commit"
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"

alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias wp="ruby -I ~/projects/personal/wp-docker/lib ˜/projects/personal/wp-docker/bin/wp-docker"

alias e="idea -e"

# alias clean_bbt_android="cd $HOME/projects/bitban; find . -name 'gradlew' | sed 's/gradlew//' | xargs -I % sh -c 'echo % ; echo "-------------" ; cd "%"; ./gradlew clean; echo; echo '"
# export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias pcd='cd $(tree -f -i -d -L 4 ~/projects | FZF_DEFAULT_OPTS="" fzf)'

