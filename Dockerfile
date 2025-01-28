FROM node:current-alpine3.20
COPY --chown=1001 *.json .
RUN npm install
COPY --chown=1001 . .
RUN npm run build
FROM nginx:mainline-bookworm-perl
COPY --from=builder /opt/app-root/src/dist /opt/app-root/src
COPY --chown=1001 conf/default.conf /opt/app-root/etc/nginx.d/