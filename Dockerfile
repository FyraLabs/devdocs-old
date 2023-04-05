FROM node:18-alpine AS builder

RUN apk add --no-cache libc6-compat curl
WORKDIR /app
COPY . .

RUN curl -sSL https://raw.githubusercontent.com/lleyton/peppermint/main/main.sh | sh

FROM node:18-alpine AS runner

WORKDIR /app
ENV NODE_ENV production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder --chown=1001:1001 /app/out .

USER nextjs

EXPOSE 3000
ENV PORT 3000

CMD ["yarn", "start"]
