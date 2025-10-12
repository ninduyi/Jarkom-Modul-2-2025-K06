# =============  Konfigurasi di Tirion (DNS Master) =============
# Di terminal Tirion
nano /etc/bind/named.conf.local
# Tambahkan ini di bawah zone "k06.com"
zone "3.214.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.214.192.in-addr.arpa";
    allow-transfer { 192.214.3.4; }; // IP Valmar
    also-notify { 192.214.3.4; };    // IP Valmar
};

# Buat File Zone untuk Reverse Lookup
nano /etc/bind/jarkom/3.214.192.in-addr.arpa
# Tambahkan konfigurasi berikut di dalam file 3.214.192.in-addr.arpa
$TTL    604800
@       IN      SOA     ns1.k06.com. root.k06.com. (
                      2025101201      ; Serial (Gunakan serial baru)
                      604800         ; Refresh
                      86400          ; Retry
                      2419200        ; Expire
                      604800 )       ; Negative Cache TTL
;

@       IN      NS      ns1.k06.com.
@       IN      NS      ns2.k06.com.

; PTR Records untuk Host di DMZ
2       IN      PTR     sirion.k06.com.   ; 192.214.3.2
5       IN      PTR     lindon.k06.com.   ; 192.214.3.5
6       IN      PTR     vingilot.k06.com. ; 192.214.3.6

# Cek Konfigurasi dan Restart
# Di terminal Tirion
named-checkconf
named-checkzone 3.214.192.in-addr.arpa /etc/bind/jarkom/3.214.192.in-addr.arpa

# Jika kedua perintah di atas tidak error (atau checkzone OK), restart BIND9
service bind9 restart

# =============  Konfigurasi di Valmar (DNS Slave) =============
# Di terminal Valmar
nano /etc/bind/named.conf.local
# Tambahkan ini di bawah zone "k06.com"
zone "3.214.192.in-addr.arpa" {
    type slave;
    masters { 192.214.3.3; }; // IP Tirion
    file "/var/lib/bind/3.214.192.in-addr.arpa";
};

# Restart BIND9 di Valmar
service bind9 restart

# =============  Verifikasi dari Klien (misal: Earendil) =============
# Cek IP Sirion (192.214.3.2)
dig @192.214.3.3 -x 192.214.3.2

# Cek IP Lindon (192.214.3.5)
dig @192.214.3.3 -x 192.214.3.5

# Cek IP Vingilot (192.214.3.6)
dig @192.214.3.3 -x 192.214.3.6