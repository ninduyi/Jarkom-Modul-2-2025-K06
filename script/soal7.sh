# ============ Konfigurasi DNS di Tirion (Master) ===========
# Di terminal Tirion, buka file konfigurasi zona untuk domain k06.com
nano /etc/bind/jarkom/k06.com
# Perbarui Record dan Naikkan Serial
$TTL    604800
@       IN      SOA     ns1.k06.com. root.k06.com. (
                      2025101203      ; Serial NAIKKAN LAGI
                      604800         ; Refresh
                      86400          ; Retry
                      2419200        ; Expire
                      604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.k06.com.
@       IN      NS      ns2.k06.com.

@       IN      A       192.214.3.2
ns1     IN      A       192.214.3.3
ns2     IN      A       192.214.3.4

; Hostnames
eonwe   IN      A       192.214.1.1
earendil IN     A       192.214.1.2
elwing  IN      A       192.214.1.3
cirdan  IN      A       192.214.2.2
elrond  IN      A       192.214.2.3
maglor  IN      A       192.214.2.4
sirion  IN      A       192.214.3.2
lindon  IN      A       192.214.3.5
vingilot IN     A       192.214.3.6

; CNAME Aliases (INI BAGIAN YANG BARU)
www     IN      CNAME   sirion.k06.com.
static  IN      CNAME   lindon.k06.com.
app     IN      CNAME   vingilot.k06.com.

# Cek Sintaks dan Restart Layanan
named-checkzone k06.com /etc/bind/jarkom/k06.com
# Jika hasilnya "OK", restart bind9
service bind9 restart


# ============ Verifikasi dari Klien ===========
# Di terminal klien (misal: Earendil) dan Cirdan
dig www.k06.com
dig static.k06.com
dig app.k06.com