#!/bin/bash

# Docker Help Script

# This script explains the Docker-related files in the project

echo -e "\e[32mReimbursement Portal - Docker Files Guide\e[0m"
echo -e "\e[32m------------------------------------------\e[0m"
echo ""

echo -e "\e[33mDOCKER CONFIGURATION FILES:\e[0m"
echo -e "\e[36m  - Dockerfile             : Main Docker image definition\e[0m"
echo -e "\e[36m  - docker-compose.yml     : Multi-container Docker configuration\e[0m"
echo -e "\e[36m  - .dockerignore          : Files to exclude from Docker builds\e[0m"
echo ""

echo -e "\e[33mSCRIPTS FOR DOCKER OPERATIONS:\e[0m"
echo -e "\e[36m  - docker_setup.ps1       : All-in-one setup script (for Windows)\e[0m"
echo -e "\e[36m  - docker_setup.sh        : All-in-one setup script (for Linux/macOS)\e[0m"
echo -e "\e[36m  - docker_build_push.ps1  : Build and push image to Docker Hub (for Windows)\e[0m"
echo -e "\e[36m  - docker_build_push.sh   : Build and push image to Docker Hub (for Linux/macOS)\e[0m"
echo -e "\e[36m  - docker_pull.ps1        : Pull image from Docker Hub (for Windows)\e[0m"
echo -e "\e[36m  - docker_pull.sh         : Pull image from Docker Hub (for Linux/macOS)\e[0m"
echo -e "\e[36m  - docker_run.ps1         : Run the container locally (for Windows)\e[0m"
echo -e "\e[36m  - docker_run.sh          : Run the container locally (for Linux/macOS)\e[0m"
echo ""

echo -e "\e[33mDOCUMENTATION:\e[0m"
echo -e "\e[36m  - DOCKER.md              : Comprehensive Docker documentation\e[0m"
echo -e "\e[36m  - DOCKER_INSTALL.md      : Docker installation guide\e[0m"
echo -e "\e[36m  - DOCKER_GUIDE.md        : Guide for building and deploying with Docker\e[0m"
echo ""

echo -e "\e[33mQUICK START:\e[0m"
echo -e "  1. Install Docker (see DOCKER_INSTALL.md)"
echo -e "  2. Run the setup script: ./docker_setup.sh"
echo -e "  3. Access the application at http://localhost:5000"
echo ""

echo -e "\e[32mFor detailed documentation, see DOCKER.md\e[0m"
