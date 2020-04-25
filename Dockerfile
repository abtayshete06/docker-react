FROM node:alpine as builder
RUN apk update && apk add --no-cache make git
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
EXPOSE 80

FROM nginx
RUN rm -rf /usr/share/nginx/html/*
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
