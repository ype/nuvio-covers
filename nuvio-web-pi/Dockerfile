# Nuvio Web (community PWA by lucaboox) built from a pinned, reviewed commit and served by Caddy.
# Builds natively on a 64-bit Raspberry Pi (arm64) or any amd64 machine.

FROM node:22-bookworm-slim AS build
ARG NUVIO_WEB_REPO=https://github.com/lucaboox/nuvio-web
ARG NUVIO_WEB_COMMIT=c140f87c007f092630efaa0f12fdc5afbb144d7d
ARG NUVIO_SUPABASE_URL=https://api.nuvio.tv
ARG NUVIO_SUPABASE_ANON_KEY
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /src
RUN git init -q . && git remote add origin "$NUVIO_WEB_REPO" \
 && git fetch -q --depth 1 origin "$NUVIO_WEB_COMMIT" && git checkout -q FETCH_HEAD
RUN npm ci --no-audit --no-fund
# The publishable key is Nuvio's public "anon" key (the same one every Nuvio app ships with), not a secret.
RUN test -n "$NUVIO_SUPABASE_ANON_KEY" || (echo "NUVIO_SUPABASE_ANON_KEY build arg is required" && exit 1) \
 && printf 'NUVIO_SUPABASE_URL=%s\nNUVIO_SUPABASE_ANON_KEY=%s\n' "$NUVIO_SUPABASE_URL" "$NUVIO_SUPABASE_ANON_KEY" > .env.local \
 && NODE_OPTIONS=--max-old-space-size=1536 npm run build

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /src/dist /srv
EXPOSE 8080
