FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Create uploads directory
RUN mkdir -p app/static/uploads && \
    chmod 777 app/static/uploads

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
