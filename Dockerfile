FROM debian:bookworm
LABEL authors="Ben Shabowski"

RUN apt-get update && apt install -y wget git python3 python3-pip default-jdk

# Get Archipelago source in here
RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
# Get the spring API in here
COPY /target/archipelago-api-1.0.0.jar /Archipelago/archipelago-api-1.0.0.jar

# Install python requirements for the Archipelago
WORKDIR Archipelago
COPY requirements.txt requirements.txt
RUN pip3 install --break-system-packages -r requirements.txt

EXPOSE 8080

CMD ["java", "-jar", "-Dspring.profiles.active=cluster", "archipelago-api-1.0.0.jar"]