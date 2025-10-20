## Di Node VINGILOT
apt update
apt install nginx php php-fpm -y

## Pastikan Service Aktif
service php8.4-fpm start
service php8.4-fpm status

service nginx start
service nginx status

## buat folder web dan file
mkdir -p /var/www/app.k06.com

##file1
nano /var/www/app.k06.com/index.php

##content index.php
<?php
echo "<h1>Welcome to Vingilot</h1>";
echo "<p>This is the home page of app.k06.com</p>";
?>

##file2 about.php
nano /var/www/app.k06.com/about.php

##content about.php
<?php
echo "<h1>About Vingilot</h1>";
echo "<p>The dynamic ship sails with PHP-FPM.</p>";
?>

##konfig untuk nginx
nano /etc/nginx/sites-available/app.k06.com

##isi konfigurasi berikut:
# Blok ini akan menangkap semua permintaan yang tidak cocok
# dengan hostname lain, seperti akses via IP.
server {
    listen 80 default_server;
    server_name _;
    return 403; # Kembalikan error Forbidden
}

server {
    listen 80;
    server_name app.k06.com;
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


## Aktifkan situs & nonaktifkan default
ln -s /etc/nginx/sites-available/app.k06.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
service nginx reload


## TES DARI KLIEN
ping app.k06.com
curl http://app.k06.com/
curl http://app.k06.com/about

## Output yang benar:

http://app.k06.com/ menampilkan “Welcome to Vingilot”

http://app.k06.com/about menampilkan “About Vingilot”

Akses pakai IP langsung (misal curl http://192.214.3.6/) harus 403 Forbidden karena dibatasi di config.
