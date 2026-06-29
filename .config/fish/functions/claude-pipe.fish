function claude-pipe --description 'Start an interactive Claude Code session seeded with command output'
    argparse --stop-nonopt p/prompt= -- $argv
    or return

    # string collect keeps the internal newlines as a single argument
    # instead of splitting on them; 2>&1 folds in stderr too.
    set --local output ($argv 2>&1 | string collect)

    claude "$output

  $_flag_prompt"
end
