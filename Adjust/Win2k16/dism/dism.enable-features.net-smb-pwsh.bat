@echo on
rem *******************************************************
rem dism.enable-features.net-smb-pwsh.bat
rem This Script will Enable Windows Server 2016 Features
rem for .Net Framework, Smb Protocol and Powershell
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Run
rem		1 if Check Integrity Error
rem		17 if Run without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TOWIN
set SUBPRODUCT_NAME=dism
set REDACT=Win11
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/%REDACT%/%SUBPRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem
set DISMEXE=%SystemRoot%\System32\dism.exe

echo Check a System Integrity...
rem
if not exist %DISMEXE% echo %DISMEXE% is not found && exit /b 1

echo Download and Run Payload..
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx3ServerFeatures /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4ServerFeatures /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:SmbDirect /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:SMB1Protocol /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShell /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellRoot /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:RemoteAccessPowerShell /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellISE /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:TelnetClient /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:TFTP /All /NoRestart

:End
echo The End of the Script %0
exit /b 0
