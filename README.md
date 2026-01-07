🎬 YTDL Termux Pro UI
YTDL Termux Pro UI adalah script downloader video & audio berbasis yt-dlp yang dirancang khusus untuk Termux, dengan tampilan UI sederhana namun informatif menggunakan spinner real-time.
Cocok untuk pengguna HP kentang maupun advanced user yang ingin downloader cepat, ringan, dan stabil.
✨ Fitur Utama
🔄 Spinner real-time + status download
🎥 Download Video & 🎵 Audio (MP3)
🌐 Mendukung platform:
YouTube
TikTok
Facebook
📺 Default resolusi 720p (fallback otomatis jika tidak tersedia)
🔊 Audio fix & konversi MP3 menggunakan ffmpeg
📂 Output langsung ke Internal Storage
⚡ Ringan, cepat, dan user-friendly
📦 Persyaratan
Pastikan kamu sudah menginstall Termux terbaru dan memberi izin storage.
🚀 Instalasi
Salin dan jalankan perintah di bawah ini satu per satu atau sekaligus:
Salin kode
Bash
pkg install -y python ffmpeg git
pip install -U yt-dlp
git clone https://github.com/RIZZKUNNN/ytdl-termux-pro.git
termux-setup-storage
cd ytdl-termux-pro
chmod +x ytdl.sh
cp ytdl.sh $PREFIX/bin/ytdl
▶️ Cara Menjalankan
Cukup ketik:
Bash
ytdl
Lalu ikuti menu yang tersedia.
📁 Lokasi Hasil Download
Semua file akan tersimpan di:
Text
/storage/emulated/0/Download/YTDL-Termux/
🛠 Teknologi yang Digunakan
Bash Script
yt-dlp
ffmpeg
Termux API
⚠️ Catatan
Pastikan koneksi internet stabil
Gunakan script ini untuk keperluan pribadi
Patuhi kebijakan platform terkait hak cipta
👤 Author
Faris Suka Mie Ayam(RIZZKUNNN)
GitHub: https://github.com/RIZZKUNNN
