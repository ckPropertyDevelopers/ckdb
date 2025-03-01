FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

WORKDIR /opt/app
COPY package*.json ./

# Install with production only
ENV NODE_ENV=production
RUN npm ci --only=production --no-audit

# Copy app files
COPY . .

# Build with memory limit
ENV NODE_OPTIONS="--max-old-space-size=512"
ENV STRAPI_TELEMETRY_DISABLED=true
RUN npm run build

# Runtime configuration
ENV PORT=1337
ENV HOST=0.0.0.0
EXPOSE 1337

CMD ["npm", "run", "start"]