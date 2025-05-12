#!/bin/bash

# Docker Pull and Run Script

# This script will:
# 1. Pull the latest Reimbursement Portal Docker image from Docker Hub
# 2. Remove any existing container with the same name
# 3. Run a new container with the appropriate settings

echo -e "\e[32mStarting Docker pull and run process...\e[0m"

# Set your Docker Hub username
DOCKER_USERNAME="lloydismael12"
IMAGE_NAME="py-portal"
VERSION="1.0"
CONTAINER_NAME="reimbursement-portal"

# Pull the latest image
echo -e "\e[33mPulling Docker image from Docker Hub...\e[0m"
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

# Remove existing container if it exists
echo -e "\e[33mChecking for existing container...\e[0m"
EXISTING=$(docker ps -a -q -f name=${CONTAINER_NAME})
if [ ! -z "$EXISTING" ]; then
    echo -e "\e[33mRemoving existing container...\e[0m"
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

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

echo -e "\e[32mContainer started! Access the application at http://localhost:5000\e[0m"
