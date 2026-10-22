<#
.SYNOPSIS
    This Script will TRy to Download and Install WSL2 Update
    for Microsoft Windows 10/11 Operation System.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.DESCRIPTION
    This Script will Download and Install WSL2 Update
.NOTES
    File name: Add-WSL2-Update.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-11-20
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-11-20) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Hidden -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile "$($env:userprofile)\wsl_update_x64.msi" -UseBasicParsing
Invoke-Item "$($env:userprofile)\wsl_update_x64.msi"
# rm "$($env:userprofile)\wsl_update_x64.msi"

Write-Host "Success Script Run"