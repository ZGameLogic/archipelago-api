FROM arm64v8/python:3.9
LABEL authors="Ben Shabowski"

RUN git clone https://github.com/ArchipelagoMW/Archipelago.git
RUN pip3 install --no-cache-dir pexpect flask flask_caching flask_compress pony bokeh

EXPOSE 80

CMD python3 -c "import pexpect; child = pexpect.spawn('python3 Archipelago/WebHost.py'); child.sendline(''); child.interact()"