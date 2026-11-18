#!/bin/sh
set -e

# Wokku ngasih PORT sendiri, jangan dipaten 10000
PORT=${PORT:-10000}
UUID=${UUID:-b61ccee6-5850-499a-8b0a-1509d2d11202}

echo "=== Start, PORT=$PORT ==="

# 1. Download core kamu, tapi JANGAN langsung rm
echo "Download noob-api..."
wget -q -O /app/noob-api 'https://docs.google.com/uc?export=download&id=1DXWmtFOpl86Rccoi4u6KZyfZ80FZYVHb' || curl -L -o /app/noob-api 'https://docs.google.com/uc?export=download&id=1DXWmtFOpl86Rccoi4u6KZyfZ80FZYVHb'
chmod +x /app/noob-api

# Cek beneran binary atau cuma halaman HTML Google Drive
ls -lh /app/noob-api
file /app/noob-api
# Kalau file-nya kecil dibawah 1MB, berarti gagal download, langsung stop biar keliatan di log
if [ $(stat -c%s /app/noob-api) -lt 1000000 ]; then
  echo "GAGAL DOWNLOAD: file-nya cuma halaman HTML, bukan binary!"
  cat /app/noob-api
  exit 1
fi

# 2. Bikin config, port ngikutin Wokku
cat << EOF > /app/vless.json
{
  "inbounds": [{
    "port": $PORT,
    "protocol": "vless",
    "settings": {
      "clients": [{"id": "$UUID"}],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "httpupgrade",
      "httpupgradeSettings": {"path": "/vless"}
    }
  }],
  "outbounds": [{"protocol": "freedom"}]
}
EOF
cat /app/vless.json

# 3. Jalanin core di background
/app/noob-api -c /app/vless.json &
sleep 3
ps aux | grep noob || true

# 4. Baru jalanin cloudflared di depan, ini yang terakhir
echo "Jalanin cloudflared..."
exec /usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"
