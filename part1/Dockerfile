FROM node:22-alpine3.19
workdir /app
ENV MESSAGE "Hello, World!"
COPY . .
EXPOSE 3000
RUN adduser --uid 1828 --disabled-password \
    --home /app \
    --gecos '' dotnetuser && chown -R dotnetuser /app
USER dotnetuser:dotnetuser    
CMD [ "node", "./app.js" ]