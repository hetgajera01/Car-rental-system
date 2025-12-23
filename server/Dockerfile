# FROM node:22-alpine AS dev
# WORKDIR /app
# COPY package*.json ./
# RUN npm install 
# COPY . .
# CMD ["npm","run","server"]

FROM node:22-alpine  AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

FROM node:22-alpine 
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=build /app/ ./

EXPOSE 3000
USER appuser
CMD ["npm","start"]