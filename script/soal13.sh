# Edit Konfigurasi Sirion
nano /etc/nginx/sites-available/www.k06.com

# Tambahkan berikut:
# ===============================
# 1. REDIRECT SERVER BLOCK
# ===============================
server {
    listen 80;
    server_name 192.214.3.2 sirion.k06.com;

    # Redirect semua request ke nama kanonik
    return 301 http://www.k06.com$request_uri;
}

# ===============================
# 2. MAIN SERVER (KANONIK)
# ===============================
server {
    listen 80;
    server_name www.k06.com;

    # Forward /static ke Lindon
    location /static/ {
        proxy_pass http://192.214.3.5/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot
    location /app/ {
        proxy_pass http://192.214.3.6/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Halaman utama
    location / {
        default_type text/html;
        return 200 "<h1>War of Wrath: Lindon bertahan</h1>
        <a href='/app/'>Go to App</a><br>
        <a href='/static/'>Go to Static</a><br>
        <a href='/admin/'>Admin</a>";
    }

    # Admin area (dilindungi)
    location = /admin {
        return 301 /admin/;
    }

    location /admin/ {
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;
        root /var/www/html;
        index index.html;
        try_files $uri $uri/ =404;
    }
}

## Cek dan Reload
nginx -t
nginx -s reload

## Tes dari Elwing
curl -I http://192.214.3.2/
## Hasil:
HTTP/1.1 301 Moved Permanently
Location: http://www.k06.com/

## Akses lewat sirion.k06.com
curl -I http://sirion.k06.com/

## Hasil
HTTP/1.1 301 Moved Permanently
Location: http://www.k06.com/

## Akses lewat www.k06.com
curl -I http://www.k06.com/
## Hasil:
HTTP/1.1 200 OK
