# Docker Pull Script

# This script will:
# 1. Pull the latest Reimbursement Portal Docker image from Docker Hub
# 2. Display information about the image

Write-Host "Pulling the Reimbursement Portal Docker image..." -ForegroundColor Green

# Set your Docker Hub username
$DOCKER_USERNAME = "lloydismael12"
$IMAGE_NAME = "py-portal"
$VERSION = "1.0"

# Pull the image
Write-Host "Pulling Docker image version $VERSION..." -ForegroundColor Yellow
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

Write-Host "Pulling latest Docker image..." -ForegroundColor Yellow
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:latest

# Display image information
Write-Host "Image information:" -ForegroundColor Green
docker images ${DOCKER_USERNAME}/${IMAGE_NAME}

Write-Host "Pull complete! You can now run the container with:" -ForegroundColor Green
Write-Host "docker run -d -p 5000:5000 --name reimbursement-portal ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}" -ForegroundColor Cyan
