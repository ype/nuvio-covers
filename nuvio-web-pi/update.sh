#!/usr/bin/env bash
# Rebuild after changing NUVIO_WEB_COMMIT in .env (or to pick up a new base image).
set -euo pipefail
cd "$(dirname "$0")"
git pull --ff-only || true
sudo docker compose up -d --build
sudo docker image prune -f >/dev/null
echo "Rebuilt with nuvio-web commit $(grep ^NUVIO_WEB_COMMIT .env | cut -d= -f2 | cut -c1-7)"
