function fgl
  git log | fzf --ansi -m | awk '{print $1}' | xargs git show
end

