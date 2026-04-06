FROM nginx:latest
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY /app-code/login/* .
