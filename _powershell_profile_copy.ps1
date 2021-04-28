$path = "$($env:USERPROFILE)\Documents\WindowsPowerShell"
If(!(test-path $path))
{
    New-Item -ItemType Directory -Force -Path $path
}
Copy-Item (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

$path = "$($env:USERPROFILE)\Documents\PowerShell"
If(!(test-path $path))
{
    New-Item -ItemType Directory -Force -Path $path
}
Copy-Item (Get-Item ".\Microsoft.PowerShell7_profile.ps1").FullName $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
