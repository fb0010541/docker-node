FROM node:iron-alpine3.21 AS builder
WORKDIR /home/node/app
COPY --chown=1001 *.json /home/node/app
RUN npm install
COPY --chown=1001 . /home/node/app
RUN npm run build
FROM nginx:mainline-bookworm-perl
COPY --from=builder /home/node/app/dist/docker-node/browser/ /usr/share/nginx/html
