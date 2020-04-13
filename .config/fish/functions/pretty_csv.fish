function pretty_csv
  column -t -s, -n "$argv" | less -F -S -X -K
end
