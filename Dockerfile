FROM node:14 AS build

COPY . /frontend

WORKDIR /frontend
RUN npm install
RUN npm run build

FROM nginx

WORKDIR /usr/share/nginx/html/frontend
COPY --from=build /frontend/build ./
COPY nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT nginx -g 'daemon off;'