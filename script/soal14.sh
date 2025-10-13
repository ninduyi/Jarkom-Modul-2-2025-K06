## Konfigurasi di Sirion (Reverse Proxy)
nano /etc/nginx/sites-available/www.k06.com
## Pastikan setiap blok proxy_pass (yaitu /app/ dan /static/) menyertakan header ini:
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Host $host;
## Jadi blok /app/ di Sirion seharusnya jadi seperti ini:
location /app/ {
    proxy_pass http://192.214.3.6/;  # Vingilot
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
}
## Reload
nginx -t
nginx -s reload

## Konfigurasi di Vingilot (Backend Web Dinamis)
nano /etc/nginx/nginx.conf
## Cari blok http { ... } di bagian atas, dan tambahkan / ubah baris ini di dalamnya:
http {
    log_format main '$http_x_real_ip - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    ...
}

# ===============================================
# Konfigurasi Nginx untuk app.k06.com (Vingilot)
# ===============================================

# Pastikan Nginx tahu bahwa Sirion adalah proxy tepercaya
# supaya access_log mencatat IP klien asli (bukan IP Sirion)
set_real_ip_from 192.214.3.2;    # IP Sirion (reverse proxy)
real_ip_header X-Real-IP;
real_ip_recursive on;

## KONFIG VINGILOT
server {
    listen 80;
    server_name app.k06.com;

    root /var/www/app.k06.com;
    index index.php;

    # -------------------------------
    # Halaman utama
    # -------------------------------
    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    # -------------------------------
    # Rewrite untuk /about tanpa .php
    # -------------------------------
    location /about {
        rewrite ^/about$ /about.php last;
    }

    # -------------------------------
    # PHP-FPM (jalankan file .php)
    # -------------------------------
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;

        # Tambahan agar IP asli juga diteruskan ke PHP
        fastcgi_param REMOTE_ADDR $remote_addr;
        fastcgi_param X-Real-IP $remote_addr;
    }

    # -------------------------------
    # Keamanan (blok file tersembunyi)
    # -------------------------------
    location ~ /\.ht {
        deny all;
    }

    # -------------------------------
    # Logging
    # -------------------------------
    access_log /var/log/nginx/app.k06.com.access.log;
    error_log /var/log/nginx/app.k06.com.error.log;
}

