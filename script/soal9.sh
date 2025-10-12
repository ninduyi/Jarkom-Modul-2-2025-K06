# ======== Buat Direktori dan File contoh di Lindon ========

# Di terminal Lindon
# Buat direktori /annals/ di dalam web root
mkdir -p /var/www/html/annals

# Buat beberapa file kosong sebagai contoh
touch /var/www/html/annals/file1.txt
touch /var/www/html/annals/catatan_rahasia.log

# ========= Konfigurasi Virtual Host Nginx =========
# Di terminal Lindon
nano /etc/nginx/sites-available/static.k06.com
# Tambahkan konfigurasi berikut di dalam file static.k06.com
server {
    listen 80;

    # Tentukan web root
    root /var/www/html;
    index index.html index.htm;

    # Respon hanya untuk hostname ini
    server_name static.k06.com;

    # Konfigurasi untuk direktori /annals/
    location /annals/ {
        # Aktifkan directory listing
        autoindex on;
    }
}

# ========= Aktifkan Virtual Host Baru dan Nonaktifkan yang Default =========
# Di terminal Lindon
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/static.k06.com /etc/nginx/sites-enabled/

# Cek Sintaks dan Restart Nginx
nginx -t
service nginx restart

# ========= Verifikasi dari Klien (misal: Earendil) =========
curl http://static.k06.com/annals/

# Hasil yang diharapkan adalah daftar file di dalam direktori /annals/, yaitu file1.txt dan catatan_rahasia.log.
