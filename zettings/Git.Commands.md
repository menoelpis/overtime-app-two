# Remove a File from Git Repo

- $ echo mytrashfile >> .gitignore
- $ git rm -r -f --cached . [Remove all items from index]
- $ git add . 
- $ git commit -m "Removed mytrashfile"