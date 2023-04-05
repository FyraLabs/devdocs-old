FROM node:18-alpine AS builder

RUN apk add --no-cache libc6-compat curl
ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

WORKDIR /app
COPY . .

USER nextjs

EXPOSE 3000
ENV PORT 3000

CMD ["yarn", "start"]
