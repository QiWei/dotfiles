@if "%DEBUG%" == "" @echo off
REM Code by QiWei.Email@gmail.com
SetLocal EnableExtensions
set "€=D:"
set "CommonFiles=%€%\PortableApps\CommonFiles"
set "#=%CommonFiles%"
set "$=%€%\Program Files"
set "PATH=%#%;%#%\bin;%$%\GnuWin32\bin;%PATH:=%"
(call CommandProcessor&call Console) 2>nul
set "€="
set "@=%SystemRoot%\System32"

if not defined Personal (
	for /f "skip=1 tokens=* delims= " %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Personal"^|findstr /v "^HKEY_"') do (
		set "ValueName=%%i"
		call set "ValueName=%%ValueName:	=    %%"
		call set "ValueData=%%ValueName:*REG_=%%"
		call call set "ValueName=%%%%ValueName:%%ValueData%%=%%%%"
		call set "ValueName=%%ValueName:    REG_=%%"
		call set "ValueData=%%ValueData:*    =%%"
		call set "%%ValueName%%=%%ValueData%%"
	)
)
if not defined HOME (
	for /f "tokens=1,2* delims=" %%i in ("%Personal%") do (
		set HOME=%%~dpi
	)
)
if "%HOME:~-1,1%"=="\" (
	set "HOME=%HOME:~0,-1%"
)
set "~=%HOME%"

if not defined LANG set "LANG=zh_CN"
REM (cd /d "%HOME%"||cd /d "%Personal%")>nul 2>&1

if defined CUR_PATH set "Old_CUR_PATH=%CUR_PATH%"
set CUR_PATH=%~dp0
set "CUR_PATH=%CUR_PATH:~0,-1%"
for %%i in ("%CUR_PATH%") do set "Parent_FolderName=%%~nxi"

rd "%@%\test_permissions" >nul 2>nul
md "%@%\test_permissions" 2>nul||(Echo ÇëÊ¹ÓÃÓÒ¼ü¹ÜÀíÔ±Éí·ÝÔËÐÐ&&Pause >nul&&Exit)
rd "%@%\test_permissions" >nul 2>nul

pushd "%CUR_PATH%"
SetLocal EnableDelayedExpansion

for /d %%i in ("%HOME%\.*") do (
	echo mklink /d "%%~nxi" "%%~i"
)

for %%i in ("%HOME%\.*") do (
	mklink "%%~nxi" "%%~fi"
)

pause
EndLocal
popd

set CUR_PATH=
if defined Old_CUR_PATH set "CUR_PATH=%Old_CUR_PATH%"

EndLocal
