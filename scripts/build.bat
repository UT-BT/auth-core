@echo off
setlocal enabledelayedexpansion

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
for %%I in ("%SCRIPT_DIR%\..\cmd\server") do set "SERVER_DIR=%%~fI"
for /f %%b in ('git log -1 --format^="%%h"') do set GIT_HASH=%%b

set "output_path=.\auth-server-%GIT_HASH%-dev"
if "%OS%"=="Windows_NT" set "output_path=!output_path!.exe"

echo Building auth-server...
go build -ldflags "-X main.version=%GIT_HASH%-dev" -o "%output_path%" "%SERVER_DIR%"
if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo Built auth-server. Saved to: %output_path%
exit /b 0