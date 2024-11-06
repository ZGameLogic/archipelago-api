#FROM arm64v8/openjdk:21-jdk-buster
#LABEL authors="Ben Shabowski"
#
## Install Python, pip, and JEP's dependencies
#RUN apt update && \
#    apt install -y python3 python3-pip python3-dev build-essential cmake libpython3-dev git && \
#    rm -rf /var/lib/apt/lists/*
#
#RUN apt install git
#RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
#
## Create an app directory for the application
#WORKDIR /app
#
## Copy the JAR file into the app directory
#COPY /target/archipelago-api-1.0.0.jar /app/archipelago-api-1.0.0.jar
#
## Expose the application port
#EXPOSE 8080
#
## Command to run your Spring Boot application
#CMD ["java", "-jar", "-Dspring.profiles.active=cert", "archipelago-api-1.0.0.jar"]

# Use the arm64v8 OpenJDK base image
FROM arm64v8/openjdk:21-jdk-buster
LABEL authors="Ben Shabowski"

RUN apt update && \
    apt install -y build-essential cmake libpython3-dev zlib1g-dev wget git && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz && \
    tar xzf Python-3.8.7.tgz && \
    cd Python-3.8.7 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.8.7.tgz Python-3.8.7

# Clone the Archipelago repository
RUN git clone https://github.com/ArchipelagoMW/Archipelago.git

# Create an app directory for the application
WORKDIR /app

# Copy the JAR file into the app directory
COPY /target/archipelago-api-1.0.0.jar /app/archipelago-api-1.0.0.jar

# Expose the application port
EXPOSE 8080

# Command to run your Spring Boot application
CMD ["java", "-jar", "-Dspring.profiles.active=cert", "archipelago-api-1.0.0.jar"]