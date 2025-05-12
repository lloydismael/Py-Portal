# GitHub Repository Setup

## Setting up the Repository

1. The GitHub repository has already been created at: https://github.com/lloydismael/Py-Portal.git

2. Initialize the local repository:
```bash
git init
```

3. Add all files:
```bash
git add .
```

4. Commit the changes:
```bash
git commit -m "Initial commit: Reimbursement Portal v1.0"
```

5. Add the remote repository:
```bash
git remote add origin https://github.com/lloydismael/Py-Portal.git
```

6. Push changes to GitHub:
```bash
git push -u origin main
```

## Creating a Release

1. Create a tag for v1.0:
```bash
git tag -a v1.0.0 -m "Reimbursement Portal v1.0.0"
```

2. Push the tag to GitHub:
```bash
git push origin v1.0.0
```

3. Go to the GitHub repository page and navigate to "Releases"

4. Create a new release based on the tag v1.0.0

5. Add release notes from the CHANGELOG.md file

6. Publish the release
