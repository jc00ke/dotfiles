Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
(mise activate pwsh) | Out-String | Invoke-Expression
(mise completion powershell) | Out-String | Invoke-Expression
(mise exec --command "starship init powershell --print-full-init") | Out-String | Invoke-Expression
(mise exec --command "zoxide init powershell") | Out-String | Invoke-Expression

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

function Convert-UuidV7 {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Uuid
    )

    # 1. Remove hyphens and isolate the first 12 chars (48-bit timestamp in v7)
    $cleanUuid = $Uuid -replace '-', ''
    if ($cleanUuid.Length -ne 32) {
        throw "Invalid UUID format. Must be a 36-character string."
    }

    $timestampHex = $cleanUuid.Substring(0, 12)

    # 2. Convert the 12-character hex to a 64-bit unsigned integer (as milliseconds)
    $unixMs = [Convert]::ToUInt64($timestampHex, 16)

    # 3. Calculate Unix Epoch and add milliseconds
    $epoch = [datetime]'1970-01-01 00:00:00Z'
    $timestamp = $epoch.AddMilliseconds($unixMs)

    # 4. Return the parsed information
    [PSCustomObject]@{
        Uuid             = $Uuid
        TimestampHex     = $timestampHex
        UnixMilliseconds = $unixMs
        DateTimeUtc      = $timestamp
        DateTimeLocal    = $timestamp.ToLocalTime()
    }
}
