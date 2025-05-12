# Docker Pull and Run Script

# This script will:
# 1. Pull the latest Reimbursement Portal Docker image from Docker Hub
# 2. Remove any existing container with the same name
# 3. Run a new container with the appropriate settings

Write-Host "Starting Docker pull and run process..." -ForegroundColor Green

# Set your Docker Hub username
$DOCKER_USERNAME = "lloydismael12"
$IMAGE_NAME = "py-portal"
$VERSION = "1.0"
$CONTAINER_NAME = "reimbursement-portal"

# Pull the latest image
Write-Host "Pulling Docker image from Docker Hub..." -ForegroundColor Yellow
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

# Remove existing container if it exists
Write-Host "Checking for existing container..." -ForegroundColor Yellow
$EXISTING = docker ps -a -q -f name=${CONTAINER_NAME}
if ($EXISTING) {
    Write-Host "Removing existing container..." -ForegroundColor Yellow
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
}

# Run the container
Write-Host "Starting new container..." -ForegroundColor Yellow
docker run -d `
  -p 5000:5000 `
  -v "${PWD}/app/static/uploads:/app/app/static/uploads" `
  -e FLASK_APP=run.py `
  -e SECRET_KEY=your-production-secret-key-change-me `
  --restart always `
  --name ${CONTAINER_NAME} `
  ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

Write-Host "Container started! Access the application at http://localhost:5000" -ForegroundColor Green
