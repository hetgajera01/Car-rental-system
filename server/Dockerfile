# FROM node:22-alpine AS dev
# WORKDIR /app
# COPY package*.json ./
# RUN npm install 
# COPY . .
# CMD ["npm","run","server"]

FROM node:22-alpine  AS prod
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 3000
CMD ["npm","start"]