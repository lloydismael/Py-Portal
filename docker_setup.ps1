# All-in-One Docker Setup Script

# This script will:
# 1. Check if Docker is installed
# 2. Pull the Reimbursement Portal image
# 3. Run the container

Write-Host "Starting Reimbursement Portal Docker setup..." -ForegroundColor Green

# Check if Docker is installed
Write-Host "Checking if Docker is installed..." -ForegroundColor Yellow
$dockerInstalled = $null
try {
    $dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue
} catch {
    # Do nothing, we'll check $dockerInstalled below
}

if (-not $dockerInstalled) {
    Write-Host "Docker is not installed or not in your PATH." -ForegroundColor Red
    Write-Host "Please install Docker Desktop from https://www.docker.com/products/docker-desktop/" -ForegroundColor Red
    Write-Host "See DOCKER_INSTALL.md for detailed instructions." -ForegroundColor Yellow
    exit 1
}

# Check if Docker is running
Write-Host "Checking if Docker is running..." -ForegroundColor Yellow
$dockerRunning = $false
try {
    $info = docker info 2>&1
    if ($LASTEXITCODE -eq 0) {
        $dockerRunning = $true
    }
} catch {
    # Do nothing, we'll check $dockerRunning below
}

if (-not $dockerRunning) {
    Write-Host "Docker is installed but not running." -ForegroundColor Red
    Write-Host "Please start Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

# Set your Docker Hub username
$DOCKER_USERNAME = "lloydismael12"
$IMAGE_NAME = "py-portal"
$VERSION = "1.0"
$CONTAINER_NAME = "reimbursement-portal"

# Pull the image
Write-Host "Pulling Docker image from Docker Hub..." -ForegroundColor Yellow
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

# Check if container already exists
Write-Host "Checking for existing container..." -ForegroundColor Yellow
$EXISTING = docker ps -a -q -f name=${CONTAINER_NAME}
if ($EXISTING) {
    Write-Host "Container already exists. Checking if it's running..." -ForegroundColor Yellow
    $RUNNING = docker ps -q -f name=${CONTAINER_NAME}
    
    if ($RUNNING) {
        Write-Host "Container is already running." -ForegroundColor Green
    } else {
        Write-Host "Starting existing container..." -ForegroundColor Yellow
        docker start ${CONTAINER_NAME}
    }
} else {
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
}

# Check if container is running
$RUNNING = docker ps -q -f name=${CONTAINER_NAME}
if ($RUNNING) {
    Write-Host "Container is running successfully!" -ForegroundColor Green
    Write-Host "Access the application at http://localhost:5000" -ForegroundColor Cyan
} else {
    Write-Host "Container failed to start. Check logs:" -ForegroundColor Red
    docker logs ${CONTAINER_NAME}
    exit 1
}
