FROM node:18-alpine AS builder
WORKDIR /app
COPY . .

RUN rm -rf .git .gitignore Dockerfile # Mintlify decides that these files are "static content"

RUN apk add --no-cache libc6-compat curl
RUN curl -sSL https://raw.githubusercontent.com/lleyton/peppermint/main/main.sh | sh

FROM node:18-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder --chown=nextjs:nodejs /app/out .

USER nextjs

EXPOSE 3000
ENV PORT 3000

CMD ["yarn", "start"]
