function env_keys -a "file" -d "Prints uniq keys from a file."
	rg "export" "$file" | awk -F'[= ]' '{ print $2 }' | sort | uniq
end
