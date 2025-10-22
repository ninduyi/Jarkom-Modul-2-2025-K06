# ==================================
# ===== DI NODE SIRION (SEMUA) =====
# ==================================

# 1. Install Nginx
apt update
apt install nginx -y

# 2. Buat Konfigurasi Virtual Host untuk Reverse Proxy
nano /etc/nginx/sites-available/www.k06.com

# == ISI FILE DENGAN KONFIGURASI DI BAWAH INI ==
# Konfigurasi ini membuat Sirion menjadi "penerjemah"
server {
    listen 80;
    server_name www.k06.com sirion.k06.com;

    # Halaman utama yang disajikan oleh Sirion sendiri
    location / {
        return 200 "<h1>War of Wrath: Lindon bertahan</h1><a href='/app/'>Go to App</a><br><a href='/static/'>Go to Static</a>";
        add_header Content-Type text/html;
    }

    # Forward permintaan /static/ ke Lindon
    location /static/ {
        proxy_pass http://192.214.3.5/;  # IP Lindon
        # PENTING: Ubah Host header agar Lindon menerima permintaan ini
        proxy_set_header Host static.k06.com;
    }


    # Forward permintaan /app/ ke Vingilot
    location /app/ {
        proxy_pass http://192.214.3.6/;  # IP Vingilot
        # PENTING: Ubah Host header agar Vingilot menerima permintaan ini
        proxy_set_header Host app.k06.com;
    }
}
# == SELESAI MENGISI FILE ==

# 3. Aktifkan Situs Baru dan Nonaktifkan Situs Default
ln -s /etc/nginx/sites-available/www.k06.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# 4. Cek Sintaks dan Restart Nginx
nginx -t
service nginx restart

# Menguji di misalnya Elrond
curl http://www.k06.com/
curl http://www.k06.com/static/
curl http://www.k06.com/app/