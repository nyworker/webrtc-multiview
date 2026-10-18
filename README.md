# webrtc-multiview

A 2×2 multiview page for [MediaMTX](https://github.com/bluenviron/mediamtx) WebRTC streams and HLS.
Each tile plays its stream over WHEP (or HLS via hls.js for URLs ending in `.m3u8`), with mute/fullscreen buttons (no pause) and a VU meter.

## Usage

1. `cp config.example.js config.js` and set your stream URLs.
   Without `config.js`, the page assumes MediaMTX runs on the host serving it.

   Each tile shows a title at the bottom center, defaulting to the stream path
   (e.g. `mystream`). To set your own, use `{ url, title }` instead of a plain URL:

   ```js
   window.STREAMS = [
     { url: 'http://mediamtx-host:8889/cam1/', title: 'Front door' },
     'http://mediamtx-host:8889/cam2/',
     // ...
   ];
   ```
2. Serve the directory over HTTP (MediaMTX rejects WHEP requests from `file://` pages):

   ```
   python3 -m http.server 8000
   ```

3. Open http://localhost:8000/

HLS servers must allow cross-origin requests (`Access-Control-Allow-Origin`).

The VU meters use Web Audio, which browsers only start after the first click or key
press on the page, so the meters stay flat until then. To have them run straight away,
allow Sound for the page in the browser's site settings, or start Chrome with
`--autoplay-policy=no-user-gesture-required` (see below).

## Kiosk mode

For a dedicated display, run `./kiosk.sh`. It serves the page on port 8000 (or
`$PORT`) if nothing is running there yet, and opens it in fullscreen Chrome with the
meters on from the start. The server stops when Chrome closes. The Chrome part is:

```
google-chrome --user-data-dir="$HOME/.config/chrome-multiview" \
  --autoplay-policy=no-user-gesture-required \
  --no-first-run --kiosk http://localhost:8000
```

`--user-data-dir` starts a separate Chrome instance; without it, the URL opens in an
already-running Chrome and the flags are ignored. Close kiosk mode with Alt+F4.
For fullscreen you can leave with F11, use `--start-fullscreen --app=http://localhost:8000`
in place of `--kiosk http://localhost:8000`.

## Test feed

`feed.sh` loops a video file into MediaMTX over RTSP with a wall-clock overlay:

```
F=video.mp4 sh feed.sh
```
