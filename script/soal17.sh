##Soal 17
### buat file
nano /root/start-services.sh

### isi dengan
```
#!/bin/bash
echo "=== Memulai layanan inti K06 ==="

HOST=$(hostname)

case "$HOST" in

# ------------------------------------
# Tirion (DNS Master)
# ------------------------------------
tirion)
    echo "[Tirion] Menyalakan BIND9 (Master DNS)..."
    mkdir -p /var/cache/bind /etc/bind/jarkom
    pkill named 2>/dev/null
    named -c /etc/bind/named.conf -g &
    ;;

# ------------------------------------
# Valmar (DNS Slave)
# ------------------------------------
valmar)
    echo "[Valmar] Menyalakan BIND9 (Slave DNS)..."
    mkdir -p /var/lib/bind
    pkill named 2>/dev/null
    named -c /etc/bind/named.conf -g &
    ;;

# ------------------------------------
# Sirion (Reverse Proxy)
# ------------------------------------
sirion)
    echo "[Sirion] Menyalakan Nginx (Reverse Proxy)..."
    nginx -t && nginx
    ;;

# ------------------------------------
# Lindon (Web Statis)
# ------------------------------------
lindon)
    echo "[Lindon] Menyalakan Nginx (Web Statis)..."
    nginx -t && nginx
    ;;

# ------------------------------------
# Vingilot (Web Dinamis PHP-FPM)
# ------------------------------------
vingilot)
    echo "[Vingilot] Menyalakan PHP-FPM & Nginx..."
    mkdir -p /var/run/php
    php-fpm8.4 -D
    nginx -t && nginx
    ;;

*)
    echo "[!] Tidak ada konfigurasi autostart untuk hostname: $HOST"
    ;;
esac

echo "[OK] Semua layanan inti ($HOST) aktif."
```
### ubah permission 
```
chmod +x /root/start-services.sh
```
### Jalankan otomatis saat WSL startup
```
echo "bash /root/start-services.sh" >> /etc/bash.bashrc
```

### TUTUP SEMUA WSL

### start tirion

### Untuk tirion/valmar
```
ps aux | grep named
dig @localhost k06.com
```
### untuk sirion/lindon
```
ps aux | grep nginx
curl http://www.k06.com/
```
### untuk vingilot
```
ps aux | grep php
curl http://app.k06.com/
```