# Base image.
FROM mongo:latest

# Install necessary components.
RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install sudo -y
RUN apt-get install git -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt-get install nodejs -y
RUN npm i -g pm2

# Create work directory.
RUN mkdir /app

# Setup Angular.
WORKDIR /app
RUN npm i -g @angular/cli
RUN ng new client --routing=true --style=scss --verbose=false

# Setup express.
RUN npm i -g express-generator
RUN express --view=pug server
WORKDIR /app/server
RUN npm i
COPY start.sh /app/
RUN chmod a+x /app/start.sh

# Expose ports.
EXPOSE 27017
EXPOSE 4200
EXPOSE 3000

# Run servers.
WORKDIR /app
CMD ["bash", "/app/start.sh"]
