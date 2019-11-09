FROM node:8-alpine

ENV NODE_ENV=production
ARG NPM_TOKEN

RUN mkdir /gate
WORKDIR /gate
COPY package.json .
COPY package-lock.json .

RUN apk --update add --no-cache bash && \
  npm install --production && \
  echo "Finished npm install"

COPY . .
CMD ["npm", "start"]
