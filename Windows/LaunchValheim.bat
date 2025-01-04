@echo off
echo Running sync script...
call D:\ValheimWorldSync\sync_before_play.bat
if %errorlevel% neq 0 (
    echo Sync failed. Check errors above.
    pause
    exit /b
)
echo Launching Valheim...
start "" "steam://rungameid/892970"