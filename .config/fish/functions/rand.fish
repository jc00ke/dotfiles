function rand -a "length"
  tr -cd '[:alnum:]' < /dev/urandom | fold -w$length | head -n1
end
