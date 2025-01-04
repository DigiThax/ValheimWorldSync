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
if not defined REPO_DIR (
    echo Error: REPO_DIR not set in %CONFIG_FILE%.
    pause
    exit /b 1
)
if not defined VALHEIM_DIR (
    echo Error: VALHEIM_DIR not set in %CONFIG_FILE%.
    pause
    exit /b 1
)
if not defined WORLD_NAME (
    echo Error: WORLD_NAME not set in %CONFIG_FILE%.
    pause
    exit /b 1
)
cd /d "%REPO_DIR%"
if %errorlevel% neq 0 (
    echo Error: Cannot change to REPO_DIR %REPO_DIR%.
    pause
    exit /b 1
)
echo Copying world from Valheim directory
copy /Y "%VALHEIM_DIR%\%WORLD_NAME%.db" "%REPO_DIR%\%WORLD_NAME%.db"
copy /Y "%VALHEIM_DIR%\%WORLD_NAME%.fwl" "%REPO_DIR%\%WORLD_NAME%.fwl"
if %errorlevel% neq 0 (
    echo Error: Failed to copy world files to %REPO_DIR%.
    pause
    exit /b 1
)
echo Committing and pushing changes
git add "%WORLD_NAME%.db" "%WORLD_NAME%.fwl"
git commit -m "Updated world save: %WORLD_NAME%"
if %errorlevel% neq 0 (
    echo No changes to commit.
) else (
    git push origin main
    if %errorlevel% neq 0 (
        echo Push failed - check connection or conflicts.
        pause
        exit /b 1
    )
)
echo Sync complete. Changes pushed! Remember to run this after playing.
pause
endlocal