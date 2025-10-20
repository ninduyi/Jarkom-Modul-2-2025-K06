# ============================= KONFIGURASI DI TIRION (DNS MASTER) =============================

# Instalasi bind9
apt-get update && apt-get install bind9 -y

# Buat Symbolic Link (Pencegahan Error)
ln -s /etc/init.d/named /etc/init.d/bind9

# Konfigurasi named.conf.local
nano /etc/bind/named.conf.local
# Tambahkan konfigurasi berikut di dalam file named.conf.local
zone "k06.com" {
    type master;
    file "/etc/bind/jarkom/k06.com";
    allow-transfer { 192.214.3.4; }; # IP Valmar
    also-notify { 192.214.3.4; };    # IP Valmar
};

# Konfigurasi named.conf.options
nano /etc/bind/named.conf.options
# Tambahkan konfigurasi berikut di dalam file named.conf.options
options {
    directory "/var/cache/bind";
    
    forwarders {
        192.168.122.1;
    };

    dnssec-validation auto;
    allow-query{any;};
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};

#  Buat Direktori dan Zone File
mkdir -p /etc/bind/jarkom
nano /etc/bind/jarkom/k06.com
# Tambahkan konfigurasi berikut di dalam file k06.com
$TTL    604800
@       IN      SOA     ns1.k06.com. root.k06.com. (
                        2025101101      ; Serial (YYYYMMDDXX)
                        604800         ; Refresh
                        86400          ; Retry
                        2419200        ; Expire
                        604800 )       ; Negative Cache TTL
;

@       IN      NS      ns1.k06.com.
@       IN      NS      ns2.k06.com.

@       IN      A       192.214.3.2     ; k06.com -> IP Sirion
ns1     IN      A       192.214.3.3     ; ns1.k06.com -> IP Tirion
ns2     IN      A       192.214.3.4     ; ns2.k06.com -> IP Valmar

# Restart
service bind9 restart


# ============================= KONFIGURASI DI VALMAR (DNS SLAVE) =============================

# Instalasi bind9
apt-get update && apt-get install bind9 -y

# Buat Symbolic Link (Pencegahan Error)
ln -s /etc/init.d/named /etc/init.d/bind9

# Konfigurasi named.conf.local
nano /etc/bind/named.conf.local
# Tambahkan konfigurasi berikut di dalam file named.conf.local
zone "k06.com" {
    type slave;
    masters { 192.214.3.3; }; // IP Tirion (Master)
    file "/var/lib/bind/k06.com";
};

# Restart
service bind9 restart


# ============================= PENGUJIAN =============================
# Di Valmar
ls -l /var/lib/bind/ # Cek apakah file k06.com sudah ada

# Di Klien (misal: Earendil)
# Install dnsutils jika belum ada
apt-get install dnsutils -y

# Bertanya ke Master (Tirion)
dig @192.214.3.3 k06.com

# Bertanya ke Slave (Valmar)
dig @192.214.3.4 k06.com














