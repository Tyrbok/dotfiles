__bbt_redmine_user=$(cat $HOME/.bitban/redmine.config.json | jq --raw-output '.user')
alias git-config-bitban="git config user.email '$__bbt_redmine_user'"
