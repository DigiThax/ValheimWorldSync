# ValheimWorldSync
Simple setup that lets you and a friend sync your Valheim world using GitHub so that progress is shared and the other individual doesn't have to be online to host the world or rent a server

What's Included

sync_config.ini: Where you set your paths and world name.
sync_before_play.bat: Pulls the latest world from GitHub before you play.
sync_after_play.bat: Saves your changes to GitHub after you play.
launch_valheim.bat: Runs the pre-play sync and starts Valheim through Steam.

Setup Steps
1. Get Git Ready

Install Git for Windows (download from git-scm.com).
Install Git LFS for big files: Open a command prompt and run git lfs install.
One of you creates a private GitHub repo (e.g., valheim-sharedworld). Share access with the other player (add them as a collaborator in repo settings).
Clone the repo to your computer in C:\ValheimSync (or another folder):git clone https://github.com/<yourusername>/valheim-sharedworld.git C:\ValheimSync



2. Set Up the Config File

Open sync_config.ini in C:\ValheimSync with Notepad.
Edit it to match your setup:
REPO_DIR: Where you cloned the repo (e.g., C:\ValheimSync).
VALHEIM_DIR: Your Valheim save folder (usually %AppData%\..\LocalLow\IronGate\Valheim\worlds_local).
WORLD_NAME: Your world’s name (e.g., sharedworld, no .db or .fwl).


Save the file. Both players need the same world name.

3. Add Initial World Files (First Player Only)

Copy your world files (sharedworld.db and sharedworld.fwl) from %AppData%\..\LocalLow\IronGate\Valheim\worlds_local to C:\ValheimSync.
In C:\ValheimSync, run these in a command prompt:git lfs track "*.db"
git lfs track "*.fwl"
git add .gitattributes
git add sharedworld.db sharedworld.fwl
git commit -m "Initial world save"
git push origin main



4. Set Up Steam

In Steam, right-click Valheim, go to Properties, and under General > Launch Options, add:C:\ValheimSync\launch_valheim.bat %command%


Change C:\ValheimSync if your repo folder is different.

5. Play and Sync

Before Playing: Launch Valheim via Steam’s Play button. The launch_valheim.bat script runs sync_before_play.bat to grab the latest world.
Play: Start or join the world in Valheim.
After Playing: Double-click sync_after_play.bat to save your changes to the repo and push them to GitHub.
Important: Only one player should play at a time to avoid conflicts. Talk to your friend (e.g., via Discord) to take turns.

Tips

Backups: Copy your world files somewhere safe before starting, just in case.
Conflicts: If sync_before_play.bat says there’s a Git conflict, talk to your friend to decide which world version to keep, then manually resolve it (ask for help if needed).
Privacy: Keep the GitHub repo private so no one else can see your world files.
World Name: Use a generic name like sharedworld to avoid sharing personal info.

If something breaks, check the command prompt messages when you run the scripts, or ask for help! Have fun exploring together!