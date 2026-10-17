# webrtc-multiview

A 2×2 multiview page for [MediaMTX](https://github.com/bluenviron/mediamtx) WebRTC streams.
Each tile plays its stream over WHEP, with mute/fullscreen buttons (no pause) and a VU meter.

## Usage

1. `cp config.example.js config.js` and set your stream URLs.
   Without `config.js`, the page assumes MediaMTX runs on the host serving it.
2. Serve the directory over HTTP (MediaMTX rejects WHEP requests from `file://` pages):

   ```
   python3 -m http.server 8000
   ```

3. Open http://localhost:8000/

The VU meters start in mono (from WebRTC stats) and switch to stereo after the first
click or key press, when the browser allows Web Audio. To get stereo straight away,
allow Sound for the page in the browser's site settings.

## Test feed

`feed.sh` loops a video file into MediaMTX over RTSP with a wall-clock overlay:

```
F=video.mp4 sh feed.sh
```
