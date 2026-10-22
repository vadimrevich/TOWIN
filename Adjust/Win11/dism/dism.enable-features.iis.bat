@echo on
rem *******************************************************
rem dism.enable-features.iis.bat
rem This Script will Enable Windows 11 Features
rem for IIS Server and Services
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

%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WebServerRole /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WebServer /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-CommonHttpFeatures /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-StaticContent /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-DefaultDocument /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-DirectoryBrowsing /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpErrors /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpRedirect /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WebDAV /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ApplicationDevelopment /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ApplicationInit /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-Security /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-RequestFiltering /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-NetFxExtensibility /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-NetFxExtensibility45 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ISAPIExtensions /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ISAPIFilter /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ASPNET /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ASP /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-CGI /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ServerSideIncludes /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HealthAndDiagnostics /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpLogging /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-LoggingLibraries /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-RequestMonitor /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpTracing /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-CustomLogging /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ODBCLogging /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-BasicAuthentication /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WindowsAuthentication /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-DigestAuthentication /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-URLAuthorization /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-IPSecurity /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-Performance /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpCompressionStatic /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HttpCompressionDynamic /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WebServerManagementTools /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ManagementConsole /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ManagementScriptingTools /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-ManagementService /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-IIS6ManagementCompatibility /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-Metabase /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-HostableWebCore /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WebSockets /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-WMICompatibility /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-LegacyScripts /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:IIS-LegacySnapIn /All /NoRestart
%DISMEXE% /Online /Enable-Feature /FeatureName:NetFx4Extended-ASPNET45 /All /NoRestart

:End
echo The End of the Script %0
exit /b 0
