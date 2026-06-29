function extrepo-list --description "List all packages available through extrepo"
    extrepo search | awk '/Found/ { gsub(/:/, ""); print $2 }' | sort
end
