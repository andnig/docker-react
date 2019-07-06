# this docker file uses two phases: Build phase and production phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# EXPOSE is only for AWS elasticbeanstalk. They automatically map this port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html