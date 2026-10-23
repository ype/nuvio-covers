# Nuvio Web on a Raspberry Pi

Runs the community [Nuvio Web](https://github.com/lucaboox/nuvio-web) PWA on a Raspberry Pi so you can use Nuvio
(collections, artwork, Trakt lists, add-ons) on an iPhone from Safari — like Stremio's web app.

The Pi only serves the app's files (≈4 MB). Sign-in and sync go to Nuvio's own servers; video streams play
directly in your browser. Any 64-bit Pi works (3B+, 4, 5, Zero 2 W).

## What it is

- **App:** `lucaboox/nuvio-web`, pinned to a reviewed commit (`NUVIO_WEB_COMMIT` in `.env`).
- **Backend:** Nuvio's official `https://api.nuvio.tv` with its public publishable key (shipped in every Nuvio app).
- **Server:** Caddy in a locked-down container (read-only, no extra privileges), port 8080.
- **HTTPS / remote access:** Tailscale Serve — a private `https://<pi>.<tailnet>.ts.net` address, no router ports opened.

## Setup

1. Flash **Raspberry Pi OS Lite (64-bit)** with Raspberry Pi Imager (enable SSH, set Wi-Fi), boot, and SSH in.
2. Get this folder and run the setup:
   ```bash
   sudo apt-get update && sudo apt-get install -y git
   git clone https://github.com/ype/nuvio-covers.git
   cd nuvio-covers/nuvio-web-pi
   ./setup.sh
   ```
   It installs Docker and Tailscale, builds the app (5–15 min the first time), and prints your `https://…ts.net` address.
   If Tailscale says HTTPS isn't enabled, follow the link it prints (admin console → DNS → enable MagicDNS + HTTPS).
3. On your iPhone: install **Tailscale** from the App Store and sign in with the same account.
4. Open the `https://…ts.net` address in **Safari**, sign in with your **Nuvio** account, then **Share → Add to Home Screen**.

At home you can also use `http://<pi-ip>:8080` in a browser, but the iPhone install needs the HTTPS address.

## Updating

The app is pinned so nothing changes under you. To move to a newer version, set `NUVIO_WEB_COMMIT` in `.env`
to the new commit (ideally after reviewing what changed) and run `./update.sh`.

## Notes

- **Playback:** Safari can't play every format (some MKV / HEVC / audio codecs) — same limits as Stremio's web app.
  The app shows a diagnostic when a stream's audio can't be decoded and can hand off to an external player (e.g. Outplayer).
- **Optional helpers:** IMDb episode ratings and "resume from external player" use two small helper services run
  by the app's author (`*.lucaboox.workers.dev`). They never see your Nuvio login or what you're watching.
- **Collections are read-only** in this client: it shows the home layout and collections synced from your account
  but never writes them, so it can't overwrite what you set up on nuvio.tv.
