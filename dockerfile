# Étape de build
FROM node:18 as build

WORKDIR /app

COPY package.json ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

# Étape de production
FROM node:18-alpine

RUN yarn global add serve

WORKDIR /app

COPY --from=build /app/build .

EXPOSE 3000

CMD ["serve", "-s", ".", "-l", "3000"]