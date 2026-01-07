#!/data/data/com.termux/files/usr/bin/bash

# ========== WARNA ==========
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

# ========== TMP TERMUX ==========
TMP_DIR="$PREFIX/tmp"
mkdir -p "$TMP_DIR"
STATUS_FILE="$TMP_DIR/ytdl_status"

set_status() {
  echo "$1" > "$STATUS_FILE"
}

# ========== SPINNER ==========
spinner() {
  pid=$!
  spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  i=0
  while kill -0 "$pid" 2>/dev/null; do
    i=$(( (i+1) %10 ))
    STATUS=$(cat "$STATUS_FILE" 2>/dev/null)
    printf "\r${CYAN}Downloading ${spin:$i:1} ${YELLOW}%s${RESET}" "$STATUS"
    sleep 0.12
  done
  wait "$pid"
  EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    printf "\r${GREEN}Download selesai ✔${RESET}\n"
  else
    printf "\r${RED}Download gagal ✖ (lihat error di atas)${RESET}\n"
  fi

  rm -f "$STATUS_FILE"
}

# ========== HEADER ==========
clear
echo -e "${BLUE}╔══════════════════════════════╗"
echo -e "║      YTDL TERMUX PRO UI      ║"
echo -e "║   By : Faris Suka Mie Ayam   ║"
echo -e "╚══════════════════════════════╝${RESET}"

# ========== INPUT URL ==========
echo -e "${YELLOW}Paste URL video:${RESET}"
IFS= read -r RAW_URL
URL=$(echo "$RAW_URL" | sed -n 's#^\(https\?://[^ ]*\).*#\1#p')

if [[ -z "$URL" ]]; then
  echo -e "${RED}URL tidak valid!${RESET}"
  exit 1
fi

# ========== PLATFORM ==========
case "$URL" in
  *tiktok.com*) PLATFORM="TikTok" ;;
  *youtube.com*|*youtu.be*) PLATFORM="YouTube" ;;
  *facebook.com*|*fb.watch*) PLATFORM="Facebook" ;;
  *instagram.com*) PLATFORM="Instagram" ;;
  *) PLATFORM="Others" ;;
esac

VIDEO_DIR="/storage/emulated/0/VideoDownloader/$PLATFORM"
MP3_DIR="/storage/emulated/0/VideoDownloader/MP3"
mkdir -p "$VIDEO_DIR" "$MP3_DIR"

# ========== MODE ==========
echo -e "\n${CYAN}Pilih Mode Download:${RESET}"
echo "[1] Video (default)"
echo "[2] MP3"
read -p "Input (Enter=1): " MODE
MODE=${MODE:-1}

# ========== MODE MP3 ==========
if [[ "$MODE" == "2" ]]; then
  set_status "Extracting audio"

  yt-dlp \
    -x --audio-format mp3 \
    --audio-quality 0 \
    -o "$MP3_DIR/%(title).80s.%(ext)s" \
    --restrict-filenames \
    "$URL" &

  spinner
  exit 0
fi

# ========== RESOLUSI ==========
echo -e "\n${CYAN}Pilih Resolusi:${RESET}"
echo "[1] 1080p"
echo "[2] 720p (default)"
echo "[3] 480p"
read -p "Input (Enter=2): " RES
RES=${RES:-2}

case $RES in
  1) FORMAT="bestvideo[height<=1080]+bestaudio/best" ;;
  3) FORMAT="bestvideo[height<=480]+bestaudio/best" ;;
  *) FORMAT="bestvideo[height<=720]+bestaudio/best" ;;
esac

# ========== INFO ==========
echo -e "\n${CYAN}Platform :${RESET} $PLATFORM"
echo -e "${CYAN}Save ke  :${RESET} $VIDEO_DIR\n"

# ========== DOWNLOAD VIDEO ==========
set_status "Fetching video & audio"

yt-dlp \
  -f "$FORMAT" \
  --merge-output-format mp4 \
  -o "$VIDEO_DIR/%(title).80s.%(ext)s" \
  --restrict-filenames \
  "$URL" &

sleep 1
set_status "Downloading & merging"
spinner
