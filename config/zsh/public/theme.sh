setopt PROMPT_SUBST

function git_prompt_info {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [ "$inside_git_repo" ]; then
    current_branch=$(git branch --show-current)
    print -P " on %{%F{151}%}$current_branch%{%f%}"
  else
    echo ""
  fi
}

export PROMPT='%(?:%F{112}:%F{red})╭─ %F{178}%~%{%f%}$(git_prompt_info)%f
%(?:%F{112}:%F{red})╰─➜ '

export GREP_COLOR='1;42m'
