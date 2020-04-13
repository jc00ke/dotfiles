function gbx
  git branch | sed '/master/d' | fzf | xargs git branch -D
end

