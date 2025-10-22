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

## Lakukan ini pada Vingilot
nano /etc/nginx/sites-available/www.k06.com

server {
    listen 80 default_server;
    server_name app.k06.com www.k06.com;
    root /var/www/app.k06.com;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location /about {
        rewrite ^/about$ /about.php last;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}

## Lakukan ini pada Lindon
nano /etc/nginx/sites-available/www.k06.com

server {
    listen 80 default_server;
    server_name static.k06.com www.k06.com;
    root /var/www/html;
    index index.html index.htm;

    # Folder annals dengan autoindex
    location /annals/ {
        autoindex on;
    }

    # Optional: tampilkan pesan kalau index tidak ada
    location / {
        try_files $uri $uri/ =404;
    }
}



## Aktifkan situs dan reload Nginx
ln -s /etc/nginx/sites-available/www.k06.com /etc/nginx/sites-enabled/
nginx -t
nginx -s reload


## Uji dari Klien (misal Elrond)
## Pastikan klien pakai DNS internal (/etc/resolv.conf mengarah ke 192.214.3.3 dan 192.214.3.4).
## Kemudian coba:
curl http://www.k06.com/
curl http://www.k06.com/static/
curl http://www.k06.com/app/

