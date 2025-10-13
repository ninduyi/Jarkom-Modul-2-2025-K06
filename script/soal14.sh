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
