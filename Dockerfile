FROM node:latest

RUN apt-get install git && mkdir -p /opt/app && cd /opt/app && git clone https://github.com/SilenceIM/silence.im . && npm install
WORKDIR /opt/app

CMD cd /opt/app && TIMEOUT=2000 PORT=80 npm start

EXPOSE 80
