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
