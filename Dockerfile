FROM node:18.10.0 as deps

WORKDIR /code

COPY package.json /code/package.json
COPY package-lock.json /code/package-lock.json

RUN npm install

FROM deps as dev

COPY . /code

FROM dev as build

RUN npm run build

FROM nginx:1.25.2 AS prod

COPY --from=build /code/dist /usr/share/nginx/html
