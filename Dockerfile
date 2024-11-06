# Use ubuntu:latest as the base image
FROM ubuntu:latest
LABEL authors="Ben Shabowski"

# Switch to an arm64-based OpenJDK image (specific to your platform)
FROM arm64v8/openjdk:21-jdk-buster

# Install Python, pip, and JEP's dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install JEP via pip (this will include native dependencies)
RUN pip3 install jep

# Set environment variables for JEP
ENV LD_LIBRARY_PATH /usr/local/lib/python3.7/site-packages/jep:$LD_LIBRARY_PATH
ENV PYTHONHOME /usr

# Create an app directory for the application
WORKDIR /app

# Copy the JAR file into the app directory
COPY /target/archipelago-api-1.0.0.jar /app/archipelago-api-1.0.0.jar

# Expose the application port
EXPOSE 8080

# Command to run your Spring Boot application
CMD ["java", "-jar", "-Dspring.profiles.active=cert", "archipelago-api-1.0.0.jar"]