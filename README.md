# 使用 Dockerfile 建立 node 容器並打包 Angular 專案，並部署在 nginx 容器中
## 環境版本
* 使用 NVM (Node Version Manager) 管理 Node 版本，安裝 Node v20.18.2，詳細請參考 https://github.com/nvm-sh/nvm
* nginx 
## Dockerfile
```
FROM node:iron-alpine3.21 AS builder
WORKDIR /home/node/app
COPY --chown=1001 *.json /home/node/app
RUN npm install
COPY --chown=1001 . /home/node/app
RUN npm run build
FROM nginx:mainline-bookworm-perl
COPY --from=builder /home/node/app/dist/docker-node/browser/ /usr/share/nginx/html
```
