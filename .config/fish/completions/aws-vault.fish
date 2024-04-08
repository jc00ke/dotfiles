if status --is-interactive
  complete -ec aws-vault

  # switch based on seeing a `--`
  complete -c aws-vault -n 'not __fish_aws_vault_is_commandline' -xa '(__fish_aws_vault_complete_arg)'
  complete -c aws-vault -n '__fish_aws_vault_is_commandline' -xa '(__fish_aws_vault_complete_commandline)'

  function __fish_aws_vault_is_commandline
    string match -q -r '^--$' -- (commandline -opc)
  end

  function __fish_aws_vault_complete_arg
    set -l parts (commandline -opc)
    set -e parts[1]

    aws-vault --completion-bash $parts
  end

  function __fish_aws_vault_complete_commandline
    set -l parts (string split --max 1 '--' -- (commandline -pc))

    complete "-C$parts[2]"
  end
end

# modified from
# https://medium.com/@fabioantunes/a-guide-for-fish-shell-completions-485ac04ac63c

# function __fish_aws_vault_complete_profiles
#   cat ~/.aws/config | grep -e "\[[^(okta)]" | awk -F'[] []' '{print $3}'
# end
#
# function __fish_complete_aws_vault_subcommand
#   set -l tokens (commandline -opc) (commandline -ct)
#   set -l index (contains -i -- -- (commandline -opc))
#   set -e tokens[1..$index]
#   complete -C"$tokens"
# end
#
# set -l aws_vault_commands help add remove list rotate exec export clear login
# complete -f -c aws-vault -n "not __fish_seen_subcommand_from $aws_vault_commands" -a add -d 'add your aws credentials'
# complete -f -c aws-vault -n "not __fish_seen_subcommand_from $aws_vault_commands" -a exec -d 'exec will run the command specified with aws credentials set in the environment'
# complete -f -c aws-vault -n "not __fish_seen_subcommand_from $aws_vault_commands" -a help -d 'help about any command'
# complete -f -c aws-vault -n "not __fish_seen_subcommand_from $aws_vault_commands" -a login -d 'login will authenticate you through aws and allow you to access your AWS environment through a browser'
# complete -f -c aws-vault -n "not __fish_seen_subcommand_from $aws_vault_commands" -a version -d 'print version'
#
# complete -f -c aws-vault -n "__fish_seen_subcommand_from exec; and not __fish_seen_subcommand_from (__fish_aws_vault_complete_profiles)" -a "(__fish_aws_vault_complete_profiles)"
#
# complete -f -c aws-vault -n "__fish_seen_subcommand_from (__fish_aws_vault_complete_profiles); and not __fish_seen_subcommand_from --" -a "--"
#
# complete -c aws-vault -n "contains -- -- (commandline -opc)" -x -a "(__fish_complete_aws_vault_subcommand)"
