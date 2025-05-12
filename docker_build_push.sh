#!/bin/bash

# Docker Build and Push Script

# This script will:
# 1. Build a Docker image for the Reimbursement Portal
# 2. Tag the image with appropriate tags
# 3. Log in to Docker Hub
# 4. Push the image to Docker Hub

echo -e "\e[32mStarting Docker build and push process...\e[0m"

# Set your Docker Hub username
DOCKER_USERNAME="lloydismael12"
IMAGE_NAME="py-portal"
VERSION="1.0"

# Build the Docker image
echo -e "\e[33mBuilding Docker image...\e[0m"
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$VERSION .

# Tag the image as latest as well
echo -e "\e[33mTagging image as latest...\e[0m"
docker tag $DOCKER_USERNAME/$IMAGE_NAME:$VERSION $DOCKER_USERNAME/$IMAGE_NAME:latest

# Log in to Docker Hub (you'll be prompted for password)
echo -e "\e[33mLogging in to Docker Hub...\e[0m"
echo -e "\e[36mPlease enter your Docker Hub password when prompted\e[0m"
docker login -u $DOCKER_USERNAME

# Push the images to Docker Hub
echo -e "\e[33mPushing images to Docker Hub...\e[0m"
docker push $DOCKER_USERNAME/$IMAGE_NAME:$VERSION
docker push $DOCKER_USERNAME/$IMAGE_NAME:latest

echo -e "\e[32mDocker build and push process completed!\e[0m"
echo -e "\e[36mYour image is now available at: docker.io/$DOCKER_USERNAME/$IMAGE_NAME:$VERSION and docker.io/$DOCKER_USERNAME/$IMAGE_NAME:latest\e[0m"
