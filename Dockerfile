FROM node:12

RUN apt-get update && apt-get install git -y --no-install-recommends && mkdir -p /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN npm install && cd node_modules/geoip-lite/ && npm run-script updatedb

CMD cd /opt/app && TIMEOUT=2000 PORT=80 npm start

EXPOSE 80
