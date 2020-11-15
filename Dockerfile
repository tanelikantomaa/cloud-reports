# FROM node:14-alpine AS builder
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install
# COPY tsconfig*.json ./
# COPY src src
# RUN npm run build
FROM node:14-alpine
ENV NODE_ENV=production
WORKDIR /
COPY . .
RUN apk add --no-cache tini
RUN chown node:node .
USER node
COPY package*.json ./
# RUN npm install
RUN npm run build
# COPY --from=builder /usr/src/app/lib/ lib/
EXPOSE 3000
ENTRYPOINT [ "./","--", "node", "/src/node_modules/.bin/tsserver" ]