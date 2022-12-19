FROM ubuntu:20.04
WORKDIR /app
COPY package.json yarn.lock ./

RUN apt-get update

RUN apt install curl -y
RUN apt-get install -y gnupg

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash

RUN apt-get install nodejs -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn -y

RUN yarn install --production

COPY . .
CMD ["node", "src/index.js"]
