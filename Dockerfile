FROM node:20-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --no-audit --no-fund

FROM node:20-alpine AS builder
ENV NEXT_TELEMETRY_DISABLED=1
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
ENV NODE_ENV=production
ENV PORT=3000
WORKDIR /app

COPY --from=builder /app/build/standalone ./
COPY --from=builder /app/build/static ./build/static
COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["node", "server.js"]


