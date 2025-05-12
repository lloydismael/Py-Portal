# Docker Build and Push Script

# This script will:
# 1. Build a Docker image for the Reimbursement Portal
# 2. Tag the image with appropriate tags
# 3. Log in to Docker Hub
# 4. Push the image to Docker Hub

Write-Host "Starting Docker build and push process..." -ForegroundColor Green

# Set your Docker Hub username
$DOCKER_USERNAME = "lloydismael12"
$IMAGE_NAME = "py-portal"
$VERSION = "1.0"

# Build the Docker image
Write-Host "Building Docker image..." -ForegroundColor Yellow
docker build -t "${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}" .

# Tag the image as latest as well
Write-Host "Tagging image as latest..." -ForegroundColor Yellow
docker tag "${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}" "${DOCKER_USERNAME}/${IMAGE_NAME}:latest"

# Log in to Docker Hub (you'll be prompted for password)
Write-Host "Logging in to Docker Hub..." -ForegroundColor Yellow
Write-Host "Please enter your Docker Hub password when prompted" -ForegroundColor Cyan
docker login -u "${DOCKER_USERNAME}"

# Push the images to Docker Hub
Write-Host "Pushing images to Docker Hub..." -ForegroundColor Yellow
docker push "${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}"
docker push "${DOCKER_USERNAME}/${IMAGE_NAME}:latest"

Write-Host "Docker build and push process completed!" -ForegroundColor Green
Write-Host "Your image is now available at: docker.io/${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION} and docker.io/${DOCKER_USERNAME}/${IMAGE_NAME}:latest" -ForegroundColor Cyan
