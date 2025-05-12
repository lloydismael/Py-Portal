# Docker Usage Guide for Reimbursement Portal

This guide covers detailed instructions for using Docker with the Reimbursement Portal application.

## Table of Contents
1. [Docker Hub Image](#docker-hub-image)
2. [Building Locally](#building-locally)
3. [Docker Compose](#docker-compose)
4. [Environment Variables](#environment-variables)
5. [Volumes](#volumes)
6. [Production Deployment](#production-deployment)
7. [Troubleshooting](#troubleshooting)

## Docker Hub Image

The Reimbursement Portal is available as a pre-built Docker image on Docker Hub:

```
lloydismael12/py-portal:1.0    # Specific version
lloydismael12/py-portal:latest  # Latest version
```

To use this image:

```bash
# Pull the image
docker pull lloydismael12/py-portal:latest

# Run a container
docker run -d -p 5000:5000 --name reimbursement-portal lloydismael12/py-portal:latest
```

## Building Locally

If you want to build the Docker image locally:

```bash
# Build the image
docker build -t reimbursement-portal:local .

# Run a container from the local image
docker run -d -p 5000:5000 --name reimbursement-portal reimbursement-portal:local
```

## Docker Compose

For easier management, use the provided docker-compose.yml file:

```bash
# Start the service
docker-compose up -d

# Stop the service
docker-compose down
```

## Environment Variables

The following environment variables can be configured:

| Variable | Description | Default |
|----------|-------------|---------|
| SECRET_KEY | Flask secret key | your-production-secret-key-change-me |
| FLASK_APP | Flask application entry point | run.py |
| DATABASE_URL | Database connection string | sqlite:///app.db |

To set environment variables:

```bash
# With docker run
docker run -d -p 5000:5000 \
  -e SECRET_KEY=my-secret-key \
  -e DATABASE_URL=sqlite:///app.db \
  --name reimbursement-portal lloydismael12/py-portal:latest

# With docker-compose (modify docker-compose.yml)
services:
  web:
    image: lloydismael12/py-portal:latest
    environment:
      - SECRET_KEY=my-secret-key
      - DATABASE_URL=sqlite:///app.db
```

## Volumes

The application uses the following volumes:

| Container Path | Purpose |
|----------------|---------|
| /app/app/static/uploads | File uploads storage |
| /app/instance | Database storage (when using SQLite) |

To persist data:

```bash
# With docker run
docker run -d -p 5000:5000 \
  -v ./uploads:/app/app/static/uploads \
  -v ./instance:/app/instance \
  ```bash
# With docker run
docker run -d -p 5000:5000 \
  -v ./uploads:/app/app/static/uploads \
  -v ./instance:/app/instance \
  --name reimbursement-portal lloydismael12/py-portal:latest

# With docker-compose (already configured)
services:
  web:
    image: lloydismael12/py-portal:latest
    volumes:
      - ./app/static/uploads:/app/app/static/uploads
      - ./instance:/app/instance
```

## Production Deployment

For production deployment:

1. Use a strong, unique SECRET_KEY
2. Consider using an external database service instead of SQLite
3. Set up proper backup procedures for the uploads and database
4. Use a reverse proxy like Nginx for TLS termination

Example docker-compose.yml for production:

```yaml
version: '3'

services:
  web:
    image: lloydismael12/py-portal:latest
    ports:
      - "5000:5000"
    volumes:
      - ./uploads:/app/app/static/uploads
      - ./instance:/app/instance
    environment:
      - FLASK_APP=run.py
      - SECRET_KEY=your-strong-secret-key-here
      - DATABASE_URL=sqlite:///app.db
    restart: always
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 5s
```

## Troubleshooting

### Common Issues

1. **Port conflicts**: If port 5000 is already in use, change the port mapping:
   ```
   docker run -d -p 8080:5000 lloydismael12/py-portal:latest
   ```

2. **Permission issues with volumes**: Ensure that the host directories have the correct permissions:
   ```
   chmod -R 755 ./uploads
   ```

3. **Container won't start**: Check logs for errors:
   ```
   docker logs reimbursement-portal
   ```

4. **Database initialization fails**: If you're using a custom database, make sure it's accessible and the schema is initialized properly.

### Viewing Logs

```bash
# View container logs
docker logs reimbursement-portal

# Follow logs in real-time
docker logs -f reimbursement-portal
```

### Accessing the Container

```bash
# Get a shell in the container
docker exec -it reimbursement-portal /bin/bash
```
