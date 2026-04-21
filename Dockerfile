# Use official Python runtime as base image
FROM python:3.11-slim

# Set working directory in container
WORKDIR /app

# Copy requirements.txt first for better caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Expose port 5000
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py

# Run the Flask application
CMD ["python", "app.py"]
