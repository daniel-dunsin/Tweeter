FROM node:21-alpine

WORKDIR /app

COPY package*.json .

RUN npm i -g @nestjs/cli

RUN yarn install

COPY . .

EXPOSE 3001

ENV NODE_ENV=production

CMD ["npx", "prisma", "migrate", "deploy", "&&", "npm", "run", "build", "&&", "npm", "run", "start"]