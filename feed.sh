ffmpeg -re -stream_loop -1 -i $F   -map 0:v:0 -map '0:a:0?' \
  -vf "scale=1920x1080,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf:text='%{localtime\:%F %T}':fontsize=48:fontcolor=white:box=1:boxcolor=black@0.5:boxborderw=10:x=w-tw-30:y=30" \
  -c:v libx264 -preset veryfast -tune zerolatency   -profile:v baseline -pix_fmt yuv420p -bf 0 \
  -c:a libopus -b:a 128k -ar 48000 -ac 2 -b:v 700K   -f rtsp -rtsp_transport tcp   rtsp://localhost:8554/mystream
