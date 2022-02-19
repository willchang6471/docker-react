FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx

# /app/build <-- all the production ouput is in the directory, that's all we care about
COPY --from=builder /app/build /usr/share/nginx/html

# no need command, nginx server will automatic start