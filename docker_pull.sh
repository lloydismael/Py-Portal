#!/bin/bash

# Docker Pull Script

# This script will:
# 1. Pull the latest Reimbursement Portal Docker image from Docker Hub
# 2. Display information about the image

echo -e "\e[32mPulling the Reimbursement Portal Docker image...\e[0m"

# Set your Docker Hub username
DOCKER_USERNAME="lloydismael12"
IMAGE_NAME="py-portal"
VERSION="1.0"

# Pull the image
echo -e "\e[33mPulling Docker image version $VERSION...\e[0m"
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}

echo -e "\e[33mPulling latest Docker image...\e[0m"
docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:latest

# Display image information
echo -e "\e[32mImage information:\e[0m"
docker images ${DOCKER_USERNAME}/${IMAGE_NAME}

echo -e "\e[32mPull complete! You can now run the container with:\e[0m"
echo -e "\e[36mdocker run -d -p 5000:5000 --name reimbursement-portal ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}\e[0m"
