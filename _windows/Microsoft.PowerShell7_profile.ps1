# Proper history etc
Import-Module PSReadLine
Import-Module Microsoft.PowerShell.Utility
Import-Module WslInterop

# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
$PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

# https://technet.microsoft.com/en-us/magazine/hh241048.aspx
$MaximumHistoryCount = 10000;

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Alt+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function NextWord
Set-PSReadLineKeyHandler -Chord Shift+Spacebar -Function SelfInsert # fixes annoying shift+space bug when writing git commit messages
Set-PSReadlineOption -BellStyle None

# (c) https://www.norlunn.net/2019/10/07/powershell-customize-the-prompt/
function global:prompt {
    $Success = $?
 
    ## Time calculation
    $LastExecutionTimeSpan = if (@(Get-History).Count -gt 0) {
        Get-History | Select-Object -Last 1 | ForEach-Object {
            New-TimeSpan -Start $_.StartExecutionTime -End $_.EndExecutionTime
        }
    }
    else {
        New-TimeSpan
    }
 
    $LastExecutionShortTime = if ($LastExecutionTimeSpan.Days -gt 0) {
        "$($LastExecutionTimeSpan.Days + [Math]::Round($LastExecutionTimeSpan.Hours / 24, 2)) d"
    }
    elseif ($LastExecutionTimeSpan.Hours -gt 0) {
        "$($LastExecutionTimeSpan.Hours + [Math]::Round($LastExecutionTimeSpan.Minutes / 60, 2)) h"
    }
    elseif ($LastExecutionTimeSpan.Minutes -gt 0) {
        "$($LastExecutionTimeSpan.Minutes + [Math]::Round($LastExecutionTimeSpan.Seconds / 60, 2)) m"
    }
    elseif ($LastExecutionTimeSpan.Seconds -gt 0) {
        "$($LastExecutionTimeSpan.Seconds + [Math]::Round($LastExecutionTimeSpan.Milliseconds / 1000, 2)) s"
    }
    elseif ($LastExecutionTimeSpan.Milliseconds -gt 0) {
        "$([Math]::Round($LastExecutionTimeSpan.TotalMilliseconds, 2)) ms"
    }
    else {
        "0 s"
    }
 
    if ($Success) {
        Write-Host -Object "[$LastExecutionShortTime] " -NoNewline -ForegroundColor Green
    }
    else {
        Write-Host -Object "! [$LastExecutionShortTime] " -NoNewline -ForegroundColor Red
    }
 
    ## History ID
    $HistoryId = $MyInvocation.HistoryId
    # Uncomment below for leading zeros
    # $HistoryId = '{0:d4}' -f $MyInvocation.HistoryId
    Write-Host -Object "$HistoryId`: " -NoNewline -ForegroundColor Cyan
 
    ## User
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    Write-Host -Object "$($env:USERNAME) ($(if ($IsAdmin){ 'A' } else { 'U' })) " -NoNewline -ForegroundColor DarkRed
 
    ## Path
    $Drive = $pwd.Drive.Name
    $Pwds = $pwd -split "\\" | Where-Object { -Not [String]::IsNullOrEmpty($_) }
    $PwdPath = if ($Pwds.Count -gt 3) {
        $ParentFolder = Split-Path -Path (Split-Path -Path $pwd -Parent) -Leaf
        $CurrentFolder = Split-Path -Path $pwd -Leaf
        "..\$ParentFolder\$CurrentFolder"
    }
    elseif ($Pwds.Count -eq 3) {
        $ParentFolder = Split-Path -Path (Split-Path -Path $pwd -Parent) -Leaf
        $CurrentFolder = Split-Path -Path $pwd -Leaf
        "$ParentFolder\$CurrentFolder"
    }
    elseif ($Pwds.Count -eq 2) {
        Split-Path -Path $pwd -Leaf
    }
    else { "" }
 
    Write-Host -Object "$Drive`:\$PwdPath" -NoNewline -ForegroundColor Magenta
 
    return "> "
}

# (c) https://gist.github.com/haf/1313318/f40a33f0cff0472c2ce9b10d6687eaeec03a9496
set-alias ls Get-ChildItemColor -force -option allscope
function Get-ChildItem-Force { ls -Force }
set-alias la Get-ChildItem-Force -option allscope

#Then in:
#C:\Users\<<username>>\Documents\WindowsPowerShell\Get-ChildItemColor.ps1

function Get-ChildItemColor {
<#
.Synopsis
  Returns childitems with colors by type.
  From http://poshcode.org/?show=878
.Description
  This function wraps Get-ChildItem and tries to output the results
  color-coded by type:
  Compressed - Yellow
  Directories - Dark Cyan
  Executables - Green
  Text Files - Cyan
  Others - Default
.ReturnValue
  All objects returned by Get-ChildItem are passed down the pipeline
  unmodified.
.Notes
  NAME:      Get-ChildItemColor
  AUTHOR:    Tojo2000 <tojo2000@tojo2000.com>
#>
  $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase `
      -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)

  $fore = $Host.UI.RawUI.ForegroundColor
  $compressed = New-Object System.Text.RegularExpressions.Regex(
      '\.(zip|tar|gz|rar)$', $regex_opts)
  $executable = New-Object System.Text.RegularExpressions.Regex(
      '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|fsx)$', $regex_opts)
  $dll_pdb = New-Object System.Text.RegularExpressions.Regex(
      '\.(dll|pdb)$', $regex_opts)
  $configs = New-Object System.Text.RegularExpressions.Regex(
      '\.(config|conf|ini)$', $regex_opts)
  $text_files = New-Object System.Text.RegularExpressions.Regex(
      '\.(txt|cfg|conf|ini|csv|log)$', $regex_opts)

  Invoke-Expression ("Get-ChildItem $args") |
    %{
      $c = $fore
      if ($_.GetType().Name -eq 'DirectoryInfo') {
        $c = 'DarkCyan'
      } elseif ($compressed.IsMatch($_.Name)) {
        $c = 'Yellow'
      } elseif ($executable.IsMatch($_.Name)) {
        $c = 'Green'
      } elseif ($text_files.IsMatch($_.Name)) {
        $c = 'Cyan'
      } elseif ($dll_pdb.IsMatch($_.Name)) {
        $c = 'DarkGreen'
      } elseif ($configs.IsMatch($_.Name)) {
        $c = 'Yellow'
      }
      $Host.UI.RawUI.ForegroundColor = $c
      echo $_
      $Host.UI.RawUI.ForegroundColor = $fore
    }
}

Import-WslCommand "apt", "awk", "cp", "emacs", "grep", "head", "less", "ls", "man", "rm", "sed", "seq", "ssh", "sudo", "tail", "vim"
