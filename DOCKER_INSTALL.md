# Docker Installation Guide for Windows

To build and push Docker images, you'll need to have Docker Desktop installed on your Windows system.

## Installation Steps

1. Download Docker Desktop for Windows from the official Docker website:
   https://www.docker.com/products/docker-desktop/

2. Run the installer and follow the installation prompts.

3. During installation, it will ask whether to use Windows Subsystem for Linux 2 (WSL 2) or Hyper-V. 
   - WSL 2 is recommended if your system supports it (Windows 10 version 2004 or higher)
   - Otherwise, use Hyper-V (requires Windows 10 Pro or Enterprise)

4. After installation, start Docker Desktop.

5. You may need to log out and log back in, or restart your computer.

6. Docker Desktop should start automatically. Look for the Docker icon in your system tray.

## Verifying Docker Installation

To verify Docker is properly installed, open PowerShell and run:

```powershell
docker --version
```

You should see output showing the Docker version number.

## Building and Pushing the Reimbursement Portal Image

Once Docker is installed, you can run the provided PowerShell script to build and push the image:

```powershell
.\docker_build_push.ps1
```

This will:
1. Build the Docker image for the Reimbursement Portal
2. Tag it with your Docker Hub username
3. Prompt you to log in to Docker Hub
4. Push the image to Docker Hub

## Using the Docker Image

After pushing to Docker Hub, you can pull and run the image on any system with Docker using:

```
docker pull lloydismael12/py-portal:1.0
docker run -p 5000:5000 lloydismael12/py-portal:1.0
```

Or using docker-compose:

```
docker-compose up
```
