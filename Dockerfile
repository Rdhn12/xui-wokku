FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl wget ca-certificates procps && rm -rf /var/lib/apt/lists/*

# Install cloudflared, ini yang kemarin ketinggalan makanya ga konek
RUN curl -L https://github.[STRIPPED 75 bytes] -o /usr/local/bin/cloudflared && chmod +x /usr/local/bin/cloudflared

WORKDIR /app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
