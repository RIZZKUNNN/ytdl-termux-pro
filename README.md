# YTDL Termux Pro UI

Downloader video & audio untuk Termux dengan UI spinner.

## Fitur
- Spinner real-time + status
- Video + MP3
- TikTok / YouTube / Facebook
- Default 720p (fallback aman)
- Audio fix (ffmpeg)
- Internal storage

## Install
```bash
pkg install -y python ffmpeg git
pip install -U yt-dlp
git clone https://github.com/RIZZKUNNN/ytdl-termux-pro.git
termux-setup-storage
cd ytdl-termux-pro
chmod +x ytdl.sh
cp ytdl.sh $PREFIX/bin/ytdl
