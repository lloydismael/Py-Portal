# Git Setup Script for Reimbursement Portal

# This script will:
# 1. Add all files if not already tracked
# 2. Commit the changes
# 3. Add the remote repository if not already added
# 4. Push to GitHub
# 5. Create and push a tag for v1.0

Write-Host "Setting up Git repository for Reimbursement Portal..." -ForegroundColor Green

# Check if git is already initialized
if (-not (Test-Path -Path ".git")) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "Git repository already initialized." -ForegroundColor Yellow
}

# Add all files
Write-Host "Adding files to git..." -ForegroundColor Yellow
git add .

# Commit changes
Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m "Reimbursement Portal v1.0"

# Check if remote is already added
$remotes = git remote
if ($remotes -notcontains "origin") {
    Write-Host "Adding remote repository..." -ForegroundColor Yellow
    git remote add origin https://github.com/lloydismael/Py-Portal.git
} else {
    Write-Host "Remote 'origin' already exists." -ForegroundColor Yellow
}

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin master

# Create tag
Write-Host "Creating tag v1.0..." -ForegroundColor Yellow
git tag -a v1.0 -m "Reimbursement Portal v1.0" -f

# Push tag
Write-Host "Pushing tag to GitHub..." -ForegroundColor Yellow
git push origin v1.0 -f

Write-Host "Git setup complete!" -ForegroundColor Green
Write-Host "Please go to GitHub to create a release based on the v1.0 tag." -ForegroundColor Cyan
