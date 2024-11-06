# Use ubuntu:latest as the base image
FROM arm64v8/ubuntu:latest
LABEL authors="Ben Shabowski"

# Switch to an arm64-based OpenJDK image (specific to your platform)
#FROM arm64v8/openjdk:21-jdk-buster

# Install Python, pip, and JEP's dependencies
RUN apt update
RUN apt install -y python3
RUN apt install -y python3-pip
RUN apt install -y python3-dev
RUN apt install -y build-essential
RUN apt install -y cmake
RUN apt install -y libpython3-dev
RUN rm -rf /var/lib/apt/lists/*

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