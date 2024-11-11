FROM python:3.9
LABEL authors="Ben Shabowski"

RUN git clone https://github.com/ArchipelagoMW/Archipelago.git

RUN sed -i '137,141d' Archipelago/WebHost.py

RUN pip3 install -r Archipelago/requirements.txt
RUN pip3 install --no-cache-dir pexpect

COPY data Archipelag/data

EXPOSE 80

#CMD ["python3", "Archipelago/WebHost.py"]
CMD python3 -c "import pexpect; child = pexpect.spawn('python3 Archipelago/WebHost.py'); child.sendline(''); child.interact()"