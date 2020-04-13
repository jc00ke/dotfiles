function docker-kill-all
  docker ps -aq | xargs docker rm -fv
end

