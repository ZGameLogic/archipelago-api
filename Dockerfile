FROM debian:bookworm
LABEL authors="Ben Shabowski"

RUN apt-get update && apt install -y wget git build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip

# Install Java
RUN apt-get install -y openjdk-21-jdk

# Install Python
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
RUN tar -xvf Python-3.10.0.tgz
RUN cd Python-3.10.0 && ./configure --enable-optimizations && make altinstall

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