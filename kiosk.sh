#!/bin/sh
# Serve the multiview page (if nothing is on $PORT yet) and open it in a fullscreen
# Chrome kiosk with the VU meters running from the start. Close with Alt+F4.
PORT=${PORT:-8000}
DIR=$(cd "$(dirname "$0")" && pwd)

if ! curl -s -o /dev/null "http://localhost:$PORT/"; then
  python3 -m http.server "$PORT" --bind 127.0.0.1 --directory "$DIR" >/dev/null 2>&1 &
  SERVER=$!
  trap 'kill $SERVER 2>/dev/null' EXIT INT TERM
  sleep 1
fi

# A separate profile makes this a new Chrome instance, so the flags take effect
# even when another Chrome is already running.
google-chrome --user-data-dir="$HOME/.config/chrome-multiview" \
  --autoplay-policy=no-user-gesture-required \
  --no-first-run --kiosk "http://localhost:$PORT/"
