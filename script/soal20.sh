# Konfigurasi di Sirion (Reverse Proxy)
nano /etc/nginx/sites-available/www.k06.com

# Konfig 
# ===============================
# Redirect dari IP & sirion.<xxxx>.com → www.<xxxx>.com
# ===============================
server {
    listen 80;
    server_name 192.214.3.2 sirion.k06.com;
    return 301 http://www.k06.com$request_uri;
}

# ===============================
# Server utama (www.k06.com)
# ===============================
server {
    listen 80;
    server_name www.k06.com;

    # ======= Halaman Depan =======
    location = / {
        default_type text/html;
        return 200 "<h1>War of Wrath: Lindon bertahan</h1>
        <a href='/app/'>Go to App</a><br>
        <a href='/static/'>Go to Static</a>";
    }

    # ======= Rute ke Aplikasi Dinamis (Vingilot) =======
    location /app/ {
        proxy_pass http://192.214.3.6/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # ======= Rute ke Aplikasi Statis (Lindon) =======
    location /static/ {
        proxy_pass http://192.214.3.5/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # ======= Admin (Basic Auth) =======
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


# Aktifkan & Reload Nginx
ln -sf /etc/nginx/sites-available/www.k06.com /etc/nginx/sites-enabled/
nginx -t
nginx -s reload
# Output yang benar
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

# Verifikasi dari Seluruh Klien
cat /etc/resolv.conf
# Hasilnya harus mengarah ke:
nameserver 192.214.3.3
nameserver 192.214.3.4

# Uji dari Elwing
ping -c 3 www.k06.com
curl http://www.k06.com/
curl http://www.k06.com/app/
curl http://www.k06.com/static/

# Uji dari Earendil
ping -c 3 www.k06.com
curl http://www.k06.com/
curl http://www.k06.com/app/
curl http://www.k06.com/static/

