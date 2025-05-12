# Docker Help Script

# This script explains the Docker-related files in the project

Write-Host "Reimbursement Portal - Docker Files Guide" -ForegroundColor Green
Write-Host "------------------------------------------" -ForegroundColor Green
Write-Host ""

Write-Host "DOCKER CONFIGURATION FILES:" -ForegroundColor Yellow
Write-Host "  - Dockerfile             : Main Docker image definition" -ForegroundColor Cyan
Write-Host "  - docker-compose.yml     : Multi-container Docker configuration" -ForegroundColor Cyan
Write-Host "  - .dockerignore          : Files to exclude from Docker builds" -ForegroundColor Cyan
Write-Host ""

Write-Host "SCRIPTS FOR DOCKER OPERATIONS:" -ForegroundColor Yellow
Write-Host "  - docker_setup.ps1       : All-in-one setup script (for Windows)" -ForegroundColor Cyan
Write-Host "  - docker_setup.sh        : All-in-one setup script (for Linux/macOS)" -ForegroundColor Cyan
Write-Host "  - docker_build_push.ps1  : Build and push image to Docker Hub (for Windows)" -ForegroundColor Cyan
Write-Host "  - docker_build_push.sh   : Build and push image to Docker Hub (for Linux/macOS)" -ForegroundColor Cyan
Write-Host "  - docker_pull.ps1        : Pull image from Docker Hub (for Windows)" -ForegroundColor Cyan
Write-Host "  - docker_pull.sh         : Pull image from Docker Hub (for Linux/macOS)" -ForegroundColor Cyan
Write-Host "  - docker_run.ps1         : Run the container locally (for Windows)" -ForegroundColor Cyan
Write-Host "  - docker_run.sh          : Run the container locally (for Linux/macOS)" -ForegroundColor Cyan
Write-Host ""

Write-Host "DOCUMENTATION:" -ForegroundColor Yellow
Write-Host "  - DOCKER.md              : Comprehensive Docker documentation" -ForegroundColor Cyan
Write-Host "  - DOCKER_INSTALL.md      : Docker installation guide" -ForegroundColor Cyan
Write-Host "  - DOCKER_GUIDE.md        : Guide for building and deploying with Docker" -ForegroundColor Cyan
Write-Host ""

Write-Host "QUICK START:" -ForegroundColor Yellow
Write-Host "  1. Install Docker (see DOCKER_INSTALL.md)" -ForegroundColor White
Write-Host "  2. Run the setup script: .\docker_setup.ps1" -ForegroundColor White
Write-Host "  3. Access the application at http://localhost:5000" -ForegroundColor White
Write-Host ""

Write-Host "For detailed documentation, see DOCKER.md" -ForegroundColor Green
