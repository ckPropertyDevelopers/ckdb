FROM node:18-alpine

# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1 && \
    rm -rf /var/cache/apk/*

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json package-lock.json ./

# Optimize npm install and build process for memory
RUN npm install --production --no-audit --no-optional && \
    npm cache clean --force

ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .

# Build with memory limit for node
ENV NODE_OPTIONS="--max-old-space-size=384"
RUN npm run build

# Expose port and start command
EXPOSE 1337
CMD ["npm", "run", "start"]