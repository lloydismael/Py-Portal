#!/bin/bash

# All-in-One Docker Setup Script

# This script will:
# 1. Check if Docker is installed
# 2. Pull the Reimbursement Portal image
# 3. Run the container

echo -e "\e[32mStarting Reimbursement Portal Docker setup...\e[0m"

# Check if Docker is installed
echo -e "\e[33mChecking if Docker is installed...\e[0m"
if ! command -v docker &> /dev/null; then
    echo -e "\e[31mDocker is not installed or not in your PATH.\e[0m"
    echo -e "\e[31mPlease install Docker from https://docs.docker.com/get-docker/\e[0m"
    echo -e "\e[33mSee DOCKER_INSTALL.md for detailed instructions.\e[0m"
    exit 1
fi

# Check if Docker is running
echo -e "\e[33mChecking if Docker is running...\e[0m"
if ! docker info &> /dev/null; then
    echo -e "\e[31mDocker is installed but not running.\e[0m"
    echo -e "\e[31mPlease start Docker and try again.\e[0m"
    exit 1
fi

# Set your Docker Hub username
DOCKER_USERNAME="lloydismael12"
IMAGE_NAME="py-portal"
VERSION="1.0"
CONTAINER_NAME="reimbursement-portal"

# Pull the image
echo -e "\e[33mPulling Docker image from Docker Hub...\e[0m"
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

# Check if container already exists
echo -e "\e[33mChecking for existing container...\e[0m"
EXISTING=$(docker ps -a -q -f name=${CONTAINER_NAME})
if [ ! -z "$EXISTING" ]; then
    echo -e "\e[33mContainer already exists. Checking if it's running...\e[0m"
    RUNNING=$(docker ps -q -f name=${CONTAINER_NAME})
    
    if [ ! -z "$RUNNING" ]; then
        echo -e "\e[32mContainer is already running.\e[0m"
    else
        echo -e "\e[33mStarting existing container...\e[0m"
        docker start ${CONTAINER_NAME}
    fi
else
    # Run the container
    echo -e "\e[33mStarting new container...\e[0m"
    docker run -d \
      -p 5000:5000 \
      -v "$(pwd)/app/static/uploads:/app/app/static/uploads" \
      -e FLASK_APP=run.py \
      -e SECRET_KEY=your-production-secret-key-change-me \
      --restart always \
      --name ${CONTAINER_NAME} \
      ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}
fi

# Check if container is running
RUNNING=$(docker ps -q -f name=${CONTAINER_NAME})
if [ ! -z "$RUNNING" ]; then
    echo -e "\e[32mContainer is running successfully!\e[0m"
    echo -e "\e[36mAccess the application at http://localhost:5000\e[0m"
else
    echo -e "\e[31mContainer failed to start. Check logs:\e[0m"
    docker logs ${CONTAINER_NAME}
    exit 1
fi
