@echo off
setlocal EnableDelayedExpansion
set "CONFIG_FILE=%~dp0SyncConfig.ini"
if not exist "%CONFIG_FILE%" (
    echo Error: %CONFIG_FILE% not found! Please create it with REPO_DIR, VALHEIM_DIR, and WORLD_NAME.
    pause
    exit /b 1
)

for /f "tokens=1,* delims==" %%a in ('type "%CONFIG_FILE%" ^| findstr /B "REPO_DIR="') do set "REPO_DIR=%%b"
for /f "tokens=1,* delims==" %%a in ('type "%CONFIG_FILE%" ^| findstr /B "VALHEIM_DIR="') do set "VALHEIM_DIR=%%b"
for /f "tokens=1,* delims==" %%a in ('type "%CONFIG_FILE%" ^| findstr /B "WORLD_NAME="') do set "WORLD_NAME=%%b"

cd /d "%REPO_DIR%"
if %errorlevel% neq 0 (
    echo Error: Cannot change to REPO_DIR %REPO_DIR%.
    pause
    exit /b 1
)

echo Pulling latest world from Git...
git pull origin main
if %errorlevel% neq 0 (
    echo Pull failed - resolve conflicts manually.
    pause
    exit /b 1
)

echo Copying world to Valheim directory...
copy /Y "%REPO_DIR%\%WORLD_NAME%.db" "%VALHEIM_DIR%\%WORLD_NAME%.db"
copy /Y "%REPO_DIR%\%WORLD_NAME%.fwl" "%VALHEIM_DIR%\%WORLD_NAME%.fwl"
if %errorlevel% neq 0 (
    echo Error: Failed to copy world files to %VALHEIM_DIR%.
    pause
    exit /b 1
)

echo Sync complete. Ready to play!
pause
endlocal