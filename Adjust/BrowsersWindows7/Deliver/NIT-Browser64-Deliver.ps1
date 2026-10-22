<#
    .SYNOPSIS
        This Script will Deliver 64-bit Browsers on Local Computer
    .DESCRIPTION
        This Script will Deliver 64-bit Browsers on Local Computer
	    (Google Chrome, Microsoft Edge, Firefox, Opera)
    .NOTES
    	File name: NIT-Browser64-Deliver.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-01
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-01) Script created
    	1.0.1 - 
#>

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Function NIT-FileDownload {
[CmdletBinding()]
param (
    [parameter(Mandatory=$true, Position=0)]
    [string]
    $URL,

    [parameter(Mandatory=$true, Position=1)]
    [string]
    $FilePath
    ) 
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($URL, $FilePath)
}

# Set a Variables
#
$DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

$aFileName01 = "MicrosoftEdge109-EnterpriseX64.msi"
$aFileName02 = "OperaSetup(win7).exe"
$aFileName03 = "FirefoxSetup115.0esr.exe"
$aFileName04 = "FirefoxSetup115.0.exe"
$aFileName05 = "GoogleChromeStandaloneEnterprise64.msi"
$aFileName06 = "MicrosoftEdgeSetup.exe"

$aLocalFilePath01 = Join-Path -Path $DownloadsDir -ChildPath $aFileName01
$aLocalFilePath02 = Join-Path -Path $DownloadsDir -ChildPath $aFileName02
$aLocalFilePath03 = Join-Path -Path $DownloadsDir -ChildPath $aFileName03
$aLocalFilePath04 = Join-Path -Path $DownloadsDir -ChildPath $aFileName04
$aLocalFilePath05 = Join-Path -Path $DownloadsDir -ChildPath $aFileName05
$aLocalFilePath06 = Join-Path -Path $DownloadsDir -ChildPath $aFileName06

# Set a Remote Hosts Variables
$anHTTP_pref = "http"
$anHTTP_domain = "win.netip4.ru"
$anHTTP_port = "80"
$anRemoteDir = "/Apps/TOWIN/Adjust/BrowsersWindows7/"
$anHTTP_user = "MSSQLSR"
$anHTTP_pass = "Admin01234"

# Set a HostName
#
$a_Host = $anHTTP_pref + "://" + $anHTTP_domain + ":" + $anHTTP_port + $anRemoteDir
$aRemoteURL01 = $a_Host + $aFileName01
$aRemoteURL02 = $a_Host + $aFileName02
$aRemoteURL03 = $a_Host + $aFileName03
$aRemoteURL04 = $a_Host + $aFileName04
$aRemoteURL05 = $a_Host + $aFileName05
$aRemoteURL06 = $a_Host + $aFileName06

# Run Payloads
#
Write-Host "Download a $aFileName01..."
if( Test-Path $aLocalFilePath01 ) {
    Remove-Item -Path $aLocalFilePath01 -Force
}
NIT-FileDownload $aRemoteURL01 $aLocalFilePath01
Write-Host "Download a $aFileName02..."
if( Test-Path $aLocalFilePath02 ) {
    Remove-Item -Path $aLocalFilePath02 -Force
}
NIT-FileDownload $aRemoteURL02 $aLocalFilePath02

Write-Host "Download a $aFileName03..."
if( Test-Path $aLocalFilePath03 ) {
    Remove-Item -Path $aLocalFilePath03 -Force
}
NIT-FileDownload $aRemoteURL03 $aLocalFilePath03

Write-Host "Download a $aFileName04..."
if( Test-Path $aLocalFilePath04 ) {
    Remove-Item -Path $aLocalFilePath04 -Force
}
NIT-FileDownload $aRemoteURL04 $aLocalFilePath04

Write-Host "Download a $aFileName05..."
if( Test-Path $aLocalFilePath05 ) {
    Remove-Item -Path $aLocalFilePath05 -Force
}
NIT-FileDownload $aRemoteURL05 $aLocalFilePath05

Write-Host "Download a $aFileName06..."
if( Test-Path $aLocalFilePath06 ) {
    Remove-Item -Path $aLocalFilePath06 -Force
}
NIT-FileDownload $aRemoteURL06 $aLocalFilePath06

