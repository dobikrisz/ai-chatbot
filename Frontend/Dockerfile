# Use the official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=True \
    PORT=8080

# Set the working directory
WORKDIR /app

# Copy only requirements first to leverage Docker caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the port Cloud Run expects
EXPOSE 8080

# Define a build-time variable
ARG PROJECT_ID

# Set it as an environment variable inside the container
ENV PROJECT_ID=${PROJECT_ID}

# Run Streamlit
CMD ["streamlit", "run", "Frontend.py", "--server.port=8080", "--server.address=0.0.0.0", "--server.enableCORS=false", "--", "--project_id=$PROJECT"]
