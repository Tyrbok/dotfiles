alias sudo="sudo "
alias ..="cd .."
alias ...="cd ../.."
alias ll="eza -l"
alias la="eza -la"

alias ls=eza
alias l='ls -lah --icons'

alias python='python3'
alias pip='pip3'

alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
#alias wp="ruby -I ~/projects/personal/wp-docker/lib ~/projects/personal/wp-docker/bin/wp-docker"
alias wp="wp-docker"

alias e="idea -e"

alias k="kubectl"

alias st="stree ./"

# alias clean_bbt_android="cd $HOME/projects/bitban; find . -name 'gradlew' | sed 's/gradlew//' | xargs -I % sh -c 'echo % ; echo "-------------" ; cd "%"; ./gradlew clean; echo; echo '"
# export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
#alias pcd='cd $(tree -f -i -d -L 4 ~/projects | FZF_DEFAULT_OPTS="" fzf)'
alias pcd='cd $(tree -a -L 5 -f -d -i ~/projects | grep -e "\.git$" | rev | cut -d"/" -f2- | rev | FZF_DEFAULT_OPTS="" fzf)'
alias poi='idea $(find ~/projects -name '.idea' -maxdepth 5 -type d | FZF_DEFAULT_OPTS="" fzf)/../'

alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias c2p-dev="npx ~/projects/personal/Code2Prompt"

# alias dl="docker ps --format '{{.ID}} - {{.Names}}' | fzf | awk '{print \$1}' | xargs -I {} docker logs {} -f"

mkdd() {
    timestamp=$(date +"%Y%m%d_%H%M")
    base_dir=${1:-./}
    prefix=${2:-data}
    dir_name="${base_dir}/${prefix}_${timestamp}"
    mkdir -p "$dir_name"
    echo "New directory '$dir_name' created."
}

ds() {
    local container_id=$(docker ps --format '{{.ID}} - {{.Names}}' | fzf)
    if [[ -n "$container_id" ]]; then
        container_id=$(echo "$container_id" | awk '{print $1}')
        if [[ -t 1 ]]; then
            docker exec -it $container_id /bin/bash
        else
            echo "No TTY available. Running in non-interactive mode."
            docker exec -i $container_id /bin/bash
        fi
    else
        echo "No container selected."
    fi
}
__print_container_info() {
  CONTAINER_ID=$1
  CONTAINER_NAME=$2
  echo -e "\033[1;34m+---------------------------------------------------+\033[0m"
  echo -e "\033[1;34m| Container ID:   \033[0m\033[1;32m$CONTAINER_ID\033[0m"
  echo -e "\033[1;34m| Container Name: \033[0m\033[1;32m$CONTAINER_NAME\033[0m"
  echo -e "\033[1;34m+---------------------------------------------------+\033[0m\n"
}

dl() {
  if [ -z "$1" ]; then
    CONTAINER=$(docker ps --format '{{.ID}} - {{.Names}}' | fzf)
    CONTAINER_ID=$(echo "$CONTAINER" | awk '{print $1}')
    CONTAINER_NAME=$(echo "$CONTAINER" | awk '{print $3}')
    __print_container_info "$CONTAINER_ID" "$CONTAINER_NAME"
    docker logs $CONTAINER_ID -f
  else
    CONTAINERS=$(docker ps --format '{{.ID}} - {{.Names}}' | grep "$1")
    COUNT=$(echo "$CONTAINERS" | wc -l)

    if [ $COUNT -eq 1 ]; then
      CONTAINER_ID=$(echo "$CONTAINERS" | awk '{print $1}')
      CONTAINER_NAME=$(echo "$CONTAINERS" | awk '{print $3}')
      __print_container_info "$CONTAINER_ID" "$CONTAINER_NAME"
      docker logs $CONTAINER_ID -f
    else
      CONTAINER=$(echo "$CONTAINERS" | fzf)
      CONTAINER_ID=$(echo "$CONTAINER" | awk '{print $1}')
      CONTAINER_NAME=$(echo "$CONTAINER" | awk '{print $3}')
      __print_container_info "$CONTAINER_ID" "$CONTAINER_NAME"
      docker logs $CONTAINER_ID -f
    fi
  fi
}
