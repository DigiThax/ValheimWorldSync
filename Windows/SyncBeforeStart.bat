@echo off
echo Pulling latest world from Git
git pull origin main
if %errorlevel% neq 0 (
    echo Pull failed - resolve conflicts manually.
    pause
    exit /b
)

echo Copying world to Valheim directory
copy /Y C:\ValheimWorldSync\Falkreath.db %AppData%\..\LocalLow\IronGate\Valheim\worlds_local\Falkreath.db
copy /Y C:\ValheimWorldSync\Falkreath.fwl %AppData%\..\LocalLow\IronGate\Valheim\worlds_local\Falkreath.fwl

echo Sync complete. Ready to play
pause