FROM node:latest

RUN apt-get install git && mkdir -p /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN npm install && cd cd node_modules/geoip-lite/ && npm run-script updatedb

CMD cd /opt/app && TIMEOUT=2000 PORT=80 npm start

EXPOSE 80
