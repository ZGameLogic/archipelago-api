FROM python:3.10
LABEL authors="Ben Shabowski"

RUN apt-get update && apt install -y alien dpkg-dev debhelper build-essential

RUN wget https://download.oracle.com/java/21/latest/jdk-21_linux-aarch64_bin.rpm
RUN alien jdk-21_linux-aarch64_bin.rpm
RUN dpkg -i jdk-21_linux-aarch64_bin.deb

RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
COPY /target/archipelago-api-1.0.0.jar /Archipelago/archipelago-api-1.0.0.jar

WORKDIR Archipelago
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 8080

CMD ["java", "-jar", "-Dspring.profiles.active=cluster", "archipelago-api-1.0.0.jar"]