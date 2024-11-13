FROM arm64v8/openjdk:21-jdk-bullseye
LABEL authors="Ben Shabowski"

RUN apt-get update
RUN apt-get install -y wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev curl libbz2-dev && \
    wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz && \
    tar -xf Python-3.10.0.tgz && \
    cd Python-3.10.0 && \
    ./configure --enable-optimizations && \
    make -j $(nproc) && \
    make altinstall && \
    cd .. && rm -rf Python-3.10.0*

RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
COPY /target/archipelago-api-1.0.0.jar /Archipelago/archipelago-api-1.0.0.jar

WORKDIR Archipelago
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 8080

CMD ["java", "-jar", "-Dspring.profiles.active=cluster", "archipelago-api-1.0.0.jar"]