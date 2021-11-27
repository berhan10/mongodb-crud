FROM node:14-slim

WORKDIR /home/node/docker-crud

COPY ./ /home/node/docker-crud

RUN yarn install

CMD yarn start

EXPOSE 3000