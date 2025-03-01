# Use multi-stage build to reduce final image size
FROM node:18-alpine as builder

# First stage: Install build dependencies
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

WORKDIR /opt/
COPY package*.json ./

# Install dependencies with specific memory limits
ENV NODE_OPTIONS="--max-old-space-size=384"
RUN npm ci --only=production --no-audit

# Second stage: Copy only necessary files
FROM node:18-alpine

# Install only runtime dependencies
RUN apk add --no-cache vips-dev

WORKDIR /opt/app
COPY --from=builder /opt/node_modules ./node_modules
COPY . .

# Build with memory constraints
ENV NODE_OPTIONS="--max-old-space-size=384"
RUN npm run build

# Configure runtime
ENV PORT=1337
ENV HOST=0.0.0.0
EXPOSE 1337

CMD ["npm", "run", "start"]