FROM python:3.11-slim

# Add labels for better container identification
LABEL maintainer="Lloyd Christian Ismael <lloydismael12@gmail.com>"
LABEL version="1.0"
LABEL description="Reimbursement Portal - A Flask web application for reimbursement management"

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Create uploads directory
RUN mkdir -p app/static/uploads && \
    chmod 777 app/static/uploads

# Create a non-root user to run the application
RUN useradd -m appuser && \
    chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=run.py
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Initialize the database
RUN python manage.py init_db

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "run:app"]
