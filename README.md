# 使用 docker 在 node 容器並打包 Angular 專案，並部署在 nginx 容器中
## demo 流程
使用 docker 指令建立 image 與執行 container 後驗證 web 服務是否正常

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
line 1-6:使用 node 容器打包 Angular init 專案  
node image 來源請參考 [dockerhub node](https://hub.docker.com/_/node/tags)  
line 7-8:將 Angular 檔案部署到 nginx 容器中  
nginx image 來源請參考 [dockerhub nginx](https://hub.docker.com/_/nginx/tags)  
### 建立 image
```
sudo docker build -t mynode:latest .
```
### 啟動 container
```
sudo docker run -p 8080:80 --rm --name my-running-node mynode:latest
```
### 驗證連結
http://localhost:8080/
