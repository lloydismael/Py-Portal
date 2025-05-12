# Docker Build and Deployment Guide

This guide provides instructions for building, pushing, and deploying the Docker image for the Reimbursement Portal application.

## Prerequisites

- Docker installed on your system (see [DOCKER_INSTALL.md](DOCKER_INSTALL.md) for Windows installation)
- Docker Hub account (username: lloydismael12)

## Building and Pushing the Image Manually

If you prefer to run the commands manually instead of using the scripts, follow these steps:

1. Build the Docker image:
```bash
docker build -t lloydismael12/py-portal:1.0 .
```

2. Tag the image as latest:
```bash
docker tag lloydismael12/py-portal:1.0 lloydismael12/py-portal:latest
```

3. Log in to Docker Hub:
```bash
docker login -u lloydismael12
```

4. Push the images to Docker Hub:
```bash
docker push lloydismael12/py-portal:1.0
docker push lloydismael12/py-portal:latest
```

## Using the Scripts

### Windows (PowerShell)

Run the PowerShell script:
```powershell
.\docker_build_push.ps1
```

### Linux/macOS

Run the Bash script:
```bash
chmod +x docker_build_push.sh
./docker_build_push.sh
```

## Deploying with Docker Compose

The simplest way to deploy the application is using Docker Compose:

1. Make sure you have Docker and Docker Compose installed
2. Create a `docker-compose.yml` file (already included in this repository)
3. Run the following command:
```bash
docker-compose up -d
```

## Running the Docker Image Directly

If you prefer to run the Docker container without Docker Compose:

```bash
docker run -d \
  -p 5000:5000 \
  -v ./app/static/uploads:/app/app/static/uploads \
  -e FLASK_APP=run.py \
  -e SECRET_KEY=your-production-secret-key-change-me \
  --restart always \
  --name reimbursement-portal \
  lloydismael12/py-portal:1.0
```

### Windows PowerShell Syntax

For Windows PowerShell, use the following command:

```powershell
docker run -d `
  -p 5000:5000 `
  -v "${PWD}/app/static/uploads:/app/app/static/uploads" `
  -e FLASK_APP=run.py `
  -e SECRET_KEY=your-production-secret-key-change-me `
  --restart always `
  --name reimbursement-portal `
  lloydismael12/py-portal:1.0
```

## Docker Hub Repository

The Docker image is available on Docker Hub at:
https://hub.docker.com/r/lloydismael12/py-portal

## Image Versions

- `1.0`: First stable release
- `latest`: Always points to the most recent stable release
