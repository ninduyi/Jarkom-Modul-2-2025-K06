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
    # Area terlindungi
    location = /admin {
        return 301 /admin/;  # redirect ke /admin/ agar cocok dengan blok berikut
    }

    location /admin/ {
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;

        root /var/www/html;
        index index.html;
        try_files $uri $uri/ =404;
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

