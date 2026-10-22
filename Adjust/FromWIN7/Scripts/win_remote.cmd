@echo on
rem ********************************************************
rem win_remote.cmd
rem This Script Add WinRM Trusted Hosts
rem and Set User Credentials for It
rem It Works only for Windows 7+
rem ********************************************************
@echo off

rem Clear Credentials

%SystemRoot%\System32\cmdkey.exe /DELETE:server-home.yudenisov.internal
%SystemRoot%\System32\cmdkey.exe /DELETE:laptop-vg.yudenisov.internal
%SystemRoot%\System32\cmdkey.exe /DELETE:win
%SystemRoot%\System32\cmdkey.exe /DELETE:win.yudenisov.internal
%SystemRoot%\System32\cmdkey.exe /DELETE:win.netip4.ru
%SystemRoot%\System32\cmdkey.exe /DELETE:win.netip6.ru

rem Add Credentials

%SystemRoot%\System32\cmdkey.exe /ADD:server-home.yudenisov.internal /USER:vagrant /PASS:0a9s8d7F
%SystemRoot%\System32\cmdkey.exe /ADD:laptop-vg.yudenisov.internal /USER:yuden /PASS:P@ssp0rtSaratov
%SystemRoot%\System32\cmdkey.exe /ADD:win /USER:vagrant /PASS:0a9s8d7F
%SystemRoot%\System32\cmdkey.exe /ADD:win.yudenisov.internal /USER:vagrant /PASS:0a9s8d7F
%SystemRoot%\System32\cmdkey.exe /ADD:win.netip4.ru /USER:vagrant /PASS:0a9s8d7F
%SystemRoot%\System32\cmdkey.exe /ADD:win.netip6.ru /USER:vagrant /PASS:0a9s8d7F

rem Set Trusted Hosts for WinRM
rem
winrm set winrm/config/client @{TrustedHosts="<local>,server-home.yudenisov.internal,laptop-vg.yudenisov.internal,win,win.yudenisov.internal,win.netip4.ru,win.netip6.ru,web.yudenisov.ru"}

