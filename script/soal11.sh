## DI SIRION

## Install nginx terlebih dahulu di sirion
apt update
apt install nginx -y

## Buat Konfigurasi situs di reverse proxy
nano /etc/nginx/sites-available/www.k06.com

## isi dengan konfig berikut:
server {
    listen 80;
    server_name www.k06.com sirion.k06.com;

    # Forward /static ke Lindon (web statis)
    location /static/ {
        proxy_pass http://192.214.3.5/;  # Lindon
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot (web dinamis)
    location /app/ {
        proxy_pass http://192.214.3.6/;  # Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Halaman utama di Sirion
    location / {
        return 200 "<h1>War of Wrath: Lindon bertahan</h1><a href='/app/'>Go to App</a><br><a href='/static/'>Go to Static</a>";
        add_header Content-Type text/html;
    }
}

## Aktifkan situs dan reload Nginx
ln -s /etc/nginx/sites-available/www.k06.com /etc/nginx/sites-enabled/
nginx -t
nginx -s reload

## Jalankan Nginx di SIrion
nginx

## Uji dari Klien (misal Elrond)
## Pastikan klien pakai DNS internal (/etc/resolv.conf mengarah ke 192.214.3.3 dan 192.214.3.4).
## Kemudian coba:
curl http://www.k06.com/
curl http://www.k06.com/static/
curl http://www.k06.com/app/

