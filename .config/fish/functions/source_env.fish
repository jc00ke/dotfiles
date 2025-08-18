function source_env
    for line in (cat $argv[1] | grep -v '^#' | grep -v '^\s*$')
        set --local name (echo $line | cut -d= -f1 | string trim)
        set --local value (echo $line | cut -d= -f2- | string trim)
        set -gx "$name" "$value"
    end
end
