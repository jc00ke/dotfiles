Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
(mise activate pwsh) | Out-String | Invoke-Expression
(&mise completion powershell) | Out-String | Invoke-Expression

Set-Alias -Name e -Value nvim
function Quit { Invoke-Command -ScriptBlock { exit } }
Set-Alias -Name xx -Value Quit

if (-not (Get-Command Invoke-Formatter -ErrorAction SilentlyContinue)) {
    $ProgressPreference = 'SilentlyContinue'
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force -Confirm:$false
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
