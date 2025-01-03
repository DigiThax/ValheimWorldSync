@echo off
echo Pulling latest world from Git
git pull origin main

echo Copying world to Valheim directory
copy /Y C:\ValheimSync\sharedworld.db %AppData%\..\LocalLow\IronGate\Valheim\worlds_local\sharedworld.db
copy /Y C:\ValheimSync\sharedworld.fwl %AppData%\..\LocalLow\IronGate\Valheim\worlds_local\sharedworld.fwl

echo Sync complete. Ready to play
pause