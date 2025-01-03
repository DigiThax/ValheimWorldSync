#!/usr/bin/env python3
""" Valheim Save Synchronization

PREREQUIREMENTS:
 - Github Account, Repo
 - Git/Git Bash on PC (CLI)

 - Git Clones or Pulls
 - Check for Save file location
 - Move files to location (specify save name)
 - Move files to Git (specify save name)

"""
import re
import os
import sys
import json
import argparse
import requests
import subprocess

from pprint import pprint

def check_save_location():
    # Pending: Set checks for linux directory
    if os.path.exists(save_path := os.path.dirname(os.getenv('APPDATA')) + "\\LocalLow\\IronGate\\Valheim"):
        print(f"Valheim Save path found at {save_path}")
        return save_path
    else:
        print("Save path couldn't be found, default path checked in at %APPDATA%/LocalLow/IronGate/Valheim")
        sys.exit(1)

def main():
    pass

if __name__ == "__main__":

    with open("config.json", "r") as f:
        config = json.load(f)

    # Run some init checks...
    save_path = check_save_location()
    print("Clonning...")
    clone = subprocess.run(["git", "clone", config['github_url']], capture_output=True, text=True)
    if clone.returncode != 0:
        print("Clone Error", clone.stderr)
        if repo := re.match(r"fatal: destination path '(.*)' already exists and is not an empty directory", clone.stderr):
            print(f"Your Valheim Saves are already present in this directory \n({os.getcwd()}), syncing your local with the cloud\n")
            # Assumes that the remote is named origin like every sane person would ever do
            sync = subprocess.run(["git", "pull", "origin"], cwd=f"{os.getcwd()}\\{repo.group(1)}", capture_output=True, text=True)
            print(sync.stdout)
        else:
            # Will elaborate the error handling when future cases arise
            print("There has been a critical failure")

    print("\nALL CHECKS DONE")

    main()

