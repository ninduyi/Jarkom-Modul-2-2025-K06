# Di Sirion
# Pastikan apache2-utils ada (buat htpasswd)
apt install apache2-utils -y

# Buat file password untuk auth
# Buat file /etc/nginx/.htpasswd berisi user admin:
htpasswd -c /etc/nginx/.htpasswd admin
# → Lalu ketik password (misalnya komdat25)

# Edit konfigurasi Nginx
nano /etc/nginx/sites-available/www.k06.com

#Tambah code berikut:
server {
    listen 80;
    server_name www.k06.com sirion.k06.com;

    # Forward /static ke Lindon (web statis)
    location /static/ {
        proxy_pass http://192.214.3.5/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot (web dinamis)
    location /app/ {
        proxy_pass http://192.214.3.6/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Area admin (terpisah, tidak di dalam /static)
    location /admin/ {
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;
        root /var/www/html;
        index index.html;
    }

    # Halaman utama di Sirion
    location / {
        return 200 "<h1>War of Wrath: Lindon bertahan</h1>
        <a href='/app/'>Go to App</a><br>
        <a href='/static/'>Go to Static</a><br>
        <a href='/admin/'>Admin</a>";
        add_header Content-Type text/html;
    }
}

# Dan buat file HTML admin-nya (kalau belum):
mkdir -p /var/www/html/admin
echo "<h1>Welcome, Administrator</h1>" > /var/www/html/admin/index.html

# Tes Konfigurasi dan reload nginx
nginx -t
# Kalau hasilnya:
nginx: configuration file /etc/nginx/nginx.conf test is successful

#Maka:
nginx -s reload

# Tes dari client (misal Elwing)
# Tanpa login
curl -i http://www.k06.com/admin/
#Hasil:
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Basic realm="Restricted Area"

# Login yang benar:
curl -i -u admin:komdat25 http://www.k06.com/admin/

#Hasil:
HTTP/1.1 200 OK
<h1>Welcome, Administrator</h1>

