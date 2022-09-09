alias sudo="sudo "
alias ..="cd .."
alias ...="cd ../.."
alias ll="exa -l"
alias la="exa -la"

alias ls=exa
alias l='ls -lah --icons'

alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias wp="ruby -I ~/projects/personal/wp-docker/lib ~/projects/personal/wp-docker/bin/wp-docker"

alias e="idea -e"

alias k="kubectl"

alias st="stree ./"

# alias clean_bbt_android="cd $HOME/projects/bitban; find . -name 'gradlew' | sed 's/gradlew//' | xargs -I % sh -c 'echo % ; echo "-------------" ; cd "%"; ./gradlew clean; echo; echo '"
# export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
#alias pcd='cd $(tree -f -i -d -L 4 ~/projects | FZF_DEFAULT_OPTS="" fzf)'
alias pcd='cd $(tree -a -L 5 -f -d -i ~/projects | grep -e "git$" | rev | cut -d"/" -f2- | rev | FZF_DEFAULT_OPTS="" fzf)'
alias poi='idea $(find ~/projects -name '.idea' -maxdepth 5 -type d | FZF_DEFAULT_OPTS="" fzf)/../'

alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
