@echo on
rem *******************************************************
rem dism.enable-features.linux.bat
rem This Script will Enable Windows 11 Features
rem for WSL Subsystem
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

%DISMEXE% /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All /NoRestart

:End
echo The End of the Script %0
exit /b 0
