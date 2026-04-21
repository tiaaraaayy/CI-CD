FROM keymetrics/pm2:10-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache \
    bash \
    git \
    curl \
    openssh

LABEL maintainer="Asya Tiara Syafitrah Susilo"

RUN mkdir -p /usr/src/apps
WORKDIR /usr/src/apps

COPY package*.json ./
RUN npm cache clean --force
RUN npm install

COPY . .

EXPOSE 3000

CMD ["pm2-runtime", "start", "npm", "--name", "app", "--", "start"]