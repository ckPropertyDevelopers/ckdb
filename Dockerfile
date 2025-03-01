# Use multi-stage build
FROM node:18-alpine as builder

# Install build dependencies
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

WORKDIR /opt/
COPY package*.json ./

# Install dependencies with increased memory limit for initial install
ENV NODE_OPTIONS="--max-old-space-size=512"
RUN npm ci --only=production --no-audit

# Copy source files
COPY . .

# Build with specific flags to reduce memory usage
ENV NODE_ENV=production
ENV STRAPI_TELEMETRY_DISABLED=true
ENV NODE_OPTIONS="--max-old-space-size=512"
RUN npm run build -- --no-optimization --no-source-maps

# Final stage
FROM node:18-alpine

# Install runtime dependencies only
RUN apk add --no-cache vips-dev

WORKDIR /opt/app

# Copy built files and dependencies
COPY --from=builder /opt/node_modules ./node_modules
COPY --from=builder /opt/build ./build
COPY --from=builder /opt/config ./config
COPY --from=builder /opt/src ./src
COPY --from=builder /opt/package.json .
COPY --from=builder /opt/favicon.ico .

# Runtime configuration
ENV PORT=1337
ENV HOST=0.0.0.0
ENV NODE_ENV=production
EXPOSE 1337

CMD ["npm", "run", "start"]