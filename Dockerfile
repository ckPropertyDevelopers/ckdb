FROM node:18-alpine AS builder

# Install build dependencies including python3 for node-gyp
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev python3 make g++

WORKDIR /opt/app
COPY package*.json ./

# Install dependencies with platform-specific bindings
ENV NODE_ENV=production
RUN npm ci --only=production --no-audit --no-optional --platform=linuxmusl

# Copy source files
COPY . .

# Build with platform specification
ENV NODE_OPTIONS="--max-old-space-size=256"
ENV STRAPI_TELEMETRY_DISABLED=true
RUN npm rebuild @swc/core --platform=linuxmusl && \
    NODE_ENV=production npm run build

# Second stage - minimal runtime
FROM node:18-alpine AS runner

# Install only runtime dependencies
RUN apk add --no-cache vips-dev

WORKDIR /opt/app

# Copy only what's needed to run
COPY --from=builder /opt/app/package*.json ./
COPY --from=builder /opt/app/build ./build
COPY --from=builder /opt/app/config ./config
COPY --from=builder /opt/app/src ./src
COPY --from=builder /opt/app/public ./public
COPY --from=builder /opt/app/node_modules ./node_modules

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337
CMD ["npm", "run", "start"]