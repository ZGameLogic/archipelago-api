FROM python:3.10
LABEL authors="Ben Shabowski"

RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
WORKDIR Archipelago
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 80

CMD python3 WebHost.py