FROM node:latest

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN hexo generate

EXPOSE 4000

CMD ["hexo", "server"]
