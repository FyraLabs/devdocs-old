FROM node:18-alpine AS builder

RUN apk add --no-cache libc6-compat curl
ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

WORKDIR /app
COPY . .

RUN curl -sSL https://raw.githubusercontent.com/lleyton/peppermint/main/main.sh | sh

USER nextjs

WORKDIR /app/out

EXPOSE 3000
ENV PORT 3000

CMD ["yarn", "start"]
