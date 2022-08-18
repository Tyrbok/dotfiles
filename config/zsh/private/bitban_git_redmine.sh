__bbt_redmine_domain=$(cat $HOME/.bitban/redmine.config.json | jq --raw-output '.domain')
__bbt_redmine_key=$(cat $HOME/.bitban/redmine.config.json | jq --raw-output '.api_key')
__bbt_redmine_base_url="https://${__bbt_redmine_domain}/"

function __bbt_git_get_title() {
  url="${__bbt_redmine_base_url}issues/$1.json"
  ret=$(curl -s --location --request GET $url --header "X-Redmine-API-Key: $__bbt_redmine_key" \
  | jq --raw-output .issue.subject)
  echo $ret
}

function bbt-git-tasks() {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

  if [ -z "$1" ]; then
    echo "❗Origin tag not found"
    echo "Usage bbt-git-tasks <origin-tag> [dest-tag]"
    echo
    echo "Latest tags: $HOME/.bitban/redmine.config.json"
    eval $show_latest_tags | sed 's/^/ *  /'
    return
  fi

  if [ "$1" = "-h" ]; then
    echo "Usage bbt-git-tasks <origin-tag> [dest-tag]"
    echo
    echo "Config file: "
    echo
    echo "{"
    echo '   "api_key": "<user-private-api-key>",'
    echo '   "user": "<email>",'
    echo '   "domain": "<domain_no-schema_no-trailing-slash>"'
    echo "}"
    echo
    echo "Latest tags: "
    eval $show_latest_tags | sed 's/^/ *  /'
    return
  fi

  if [ -z "$2" ]; then
      dest="latest commit"
  fi

if [ "$inside_git_repo" ]; then
    echo "🚀 Find all redmine task from tag '$1' to '$dest'"
  else
    echo "❗Not in git repository..."
    return;
  fi

  echo

  origin=$1
  dest=$2

  show_latest_tags="git for-each-ref --sort=-creatordate --format '%(refname) %(creatordate)' refs/tags \
  | cut -d' ' -f1 | sed 's/refs\/tags\///g' | head -n 5"

  if [ -z $(git tag | grep "$origin$") ]; then
    echo "❗️Origin Tag '$origin' not found"
    echo ""
    echo "Latest tags: "
    eval $show_latest_tags | sed 's/^/ *  /'
    return
  fi

  if [ -n "$2" ]; then
        if [ -z $(git tag | grep "$dest") ]; then
          echo
          echo "❗️Destination Tag '$dest' not found"
          echo "Latest tags: "
          eval $show_latest_tags | sed 's/^/ *  /'
          return
        fi
  fi

  matches_url=$(git log $origin...$dest | grep -e "${__bbt_redmine_domain}/issues/\(\d\+\)" -o | cut -d'/' -f3)
  matches_ids=$(git log $origin...$dest | grep -e '\#\(\d\+\)' -o)
  ids=$(echo $matches_url\\n$matches_ids)
  unique_ids=$(echo $ids | sort | uniq )

  report=$(echo $unique_ids | while read id; do
    echo "${__bbt_redmine_base_url}issues/$id | "$(__bbt_git_get_title $id)
  done)
  echo $report

  echo
  echo "🎉 Done."
}
