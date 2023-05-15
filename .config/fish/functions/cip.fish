function cip -a "command"
	for p in $PATH
		if test -x "$p/$command"
			echo "$command in $p"
		end
	end
end
