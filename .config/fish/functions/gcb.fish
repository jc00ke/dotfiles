function gcb
  git branch | fzf | xargs git checkout
end

