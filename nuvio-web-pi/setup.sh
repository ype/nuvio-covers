#!/usr/bin/env bash
# One-time setup of Nuvio Web on a Raspberry Pi (64-bit Raspberry Pi OS).
# Installs Docker + Tailscale if needed, builds and starts the site, and publishes it over HTTPS on your tailnet.
set -euo pipefail
cd "$(dirname "$0")"

arch=$(uname -m)
if [ "$arch" != "aarch64" ] && [ "$arch" != "x86_64" ]; then
  echo "This needs a 64-bit OS (found $arch). Reflash with Raspberry Pi OS Lite (64-bit)." >&2; exit 1
fi

if ! command -v docker >/dev/null; then
  echo "== Installing Docker"
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
fi

# Building the app needs ~1.5 GB of memory; give small Pis some swap for the build.
mem_mb=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
if [ "$mem_mb" -lt 3000 ] && [ -f /etc/dphys-swapfile ] && ! grep -q '^CONF_SWAPSIZE=2048' /etc/dphys-swapfile; then
  echo "== ${mem_mb} MB RAM: setting 2 GB swap for the build"
  sudo sed -i 's/^#\?CONF_SWAPSIZE=.*/CONF_SWAPSIZE=2048/' /etc/dphys-swapfile
  sudo systemctl restart dphys-swapfile
fi

echo "== Building and starting Nuvio Web (first build takes ~5-15 min on a Pi)"
sudo docker compose up -d --build
for i in $(seq 1 30); do curl -fsS -o /dev/null http://127.0.0.1:8080/ && break; sleep 2; done
curl -fsS -o /dev/null http://127.0.0.1:8080/ && echo "   OK: http://$(hostname -I | awk '{print $1}'):8080 (home network, plain HTTP)"

if ! command -v tailscale >/dev/null; then
  echo "== Installing Tailscale"
  curl -fsSL https://tailscale.com/install.sh | sh
fi
if ! tailscale status >/dev/null 2>&1; then
  echo "== Log in to Tailscale (open the link it prints)"
  sudo tailscale up
fi
echo "== Publishing over HTTPS on your tailnet"
sudo tailscale serve --bg 8080
tailscale serve status
echo
echo "Done. Open the https://….ts.net address above in Safari on your iPhone (with Tailscale on),"
echo "sign in with your Nuvio account, then Share → Add to Home Screen."
