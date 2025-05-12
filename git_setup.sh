# Git Setup Script for Reimbursement Portal

# This script will:
# 1. Initialize a git repository
# 2. Add all files
# 3. Commit the changes
# 4. Add the remote repository
# 5. Push to GitHub
# 6. Create and push a tag for v1.0

# Initialize git repository
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Reimbursement Portal v1.0"

# Add remote repository
git remote add origin https://github.com/lloydismael/Py-Portal.git

# Push to GitHub
git push -u origin main

# Create tag
git tag -a v1.0 -m "Reimbursement Portal v1.0"

# Push tag
git push origin v1.0

echo "Git setup complete!"
echo "Please go to GitHub to create a release based on the v1.0 tag."
