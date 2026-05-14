(&mise activate pwsh) | Out-String | Invoke-Expression
(&mise completion powershell) | Out-String | Invoke-Expression

Set-Alias -Name e -Value nvim
function Quit { Invoke-Command -ScriptBlock { exit } }
Set-Alias -Name xx -Value Quit
