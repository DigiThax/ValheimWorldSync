import re
import os
import json
import requests
import subprocess

from pprint import pprint


def main():
    pass

if __name__ == "__main__":

    # Run some init steps here
    with open("config.json", "r") as f:
        config = json.load(f)

    # Run some init checks...
    print("Clonning...")
    clone = subprocess.run(["git", "clone", config['github_url']], capture_output=True, text=True)
    if clone.returncode != 0:
        print("Clone Error", clone.stderr)
        if repo := re.match(r"fatal: destination path '(.*)' already exists and is not an empty directory", clone.stderr):
            print(f"Your Valheim Saves are already present in this directory \n({os.getcwd()}), syncing your local with the cloud\n")
            # Assumes that the remote is named origin like every sane person would ever do
            sync = subprocess.run(["git", "pull", "origin"], cwd=f"{os.getcwd()}/{repo.group(1)}", capture_output=True, text=True)
            print(sync.stdout)
        else:
            # Will elaborate the error handling when future cases arise
            print("There has been a critical failure")

    print("\nALL CHECKS DONE")

    main()

