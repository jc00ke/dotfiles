# Define source and destination paths
$DotFilesPath = "$HOME\dotfiles"
Set-Location -Path $DotFilesPath
git pull

function SyncMyFiles {
  param(
    [string]$SourcePath,
    [string]$DestinationPath
  )


  # 1. Delete files and directories in Destination that are NOT in Source

  # Get all items (files and directories) in the Destination recursively
  $DestinationItems = Get-ChildItem -Path $DestinationPath -Recurse -Force

  foreach ($Item in $DestinationItems) {
      # Construct the corresponding path in the source
      $SourceEquivalentPath = $Item.FullName.Replace($DestinationPath, $SourcePath)

      # Check if the item exists in the Source
      if (-not (Test-Path -Path $SourceEquivalentPath -PathType Any)) {
          Write-Host "Deleting $($Item.FullName) as it's not in the source."
          Remove-Item -Path $Item.FullName -Recurse -Force -ErrorAction SilentlyContinue
      }
  }

  # 2. Copy files from Source to Destination, overwriting existing ones

  # Ensure the destination directory exists (Copy-Item -Recurse will create subfolders)
  Write-Host "Ensuring $DestinationPath exists..."
  New-Item -ItemType Directory -Path $DestinationPath -ErrorAction SilentlyContinue

  # Copy all files and folders from source to destination recursively
  Write-Host "Copying files from $SourcePath to $DestinationPath"
  Copy-Item -Path "$SourcePath\*" -Destination "$DestinationPath\" -Recurse -Force
}

SyncMyFiles -SourcePath "$DotFilesPath\.config\nvim" -DestinationPath "$env:LOCALAPPDATA\nvim"
SyncMyFiles -SourcePath "$DotFilesPath\.config\mise" -DestinationPath "$HOME\.config\mise"
SyncMyFiles -SourcePath "$DotFilesPath\.config\1Password" -DestinationPath "$env:LOCALAPPDATA\1Password\config\"
SyncMyFiles -SourcePath "$DotFilesPath\_curlrc" -DestinationPath "$HOME\_curlrc"
SyncMyFiles -SourcePath "$DotFilesPath\.config\powershell" -DestinationPath "$HOME\Documents\PowerShell"

Set-Location -Path $HOME
