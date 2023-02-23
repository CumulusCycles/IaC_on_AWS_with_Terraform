FROM node:alpine

WORKDIR /src

COPY ./src/package.json .
RUN npm install

COPY ./src/ .

EXPOSE 3000

CMD ["node", "server.js"]