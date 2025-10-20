# ====== Mengatur Hostname di Setiap Node (Total 11 Host) ======

# Eonwe
hostname eonwe
echo "eonwe" > /etc/hostname

# Earendil
hostname earendil
echo "earendil" > /etc/hostname

# Elwing
hostname elwing
echo "elwing" > /etc/hostname

# Cirdan
hostname cirdan
echo "cirdan" > /etc/hostname

# Elrond
hostname elrond
echo "elrond" > /etc/hostname

# Maglor
hostname maglor
echo "maglor" > /etc/hostname

# Sirion
hostname sirion
echo "sirion" > /etc/hostname

# Tirion
hostname tirion
echo "tirion" > /etc/hostname

# Valmar
hostname valmar
echo "valmar" > /etc/hostname

# Lindon
hostname lindon
echo "lindon" > /etc/hostname

# Vingilot
hostname vingilot
echo "vingilot" > /etc/hostname

# ========== Menambahkan A Record di DNS Master (Tirion) ==========

# Di terminal Tirion
nano /etc/bind/jarkom/k06.com

# Naikkan nomor serial dan tambahkan A Record untuk setiap host. Sesuai soal, kita mengecualikan tirion dan valmar karena sudah diwakili oleh ns1 dan ns2.
$TTL    604800
@       IN      SOA     ns1.k06.com. root.k06.com. (
                      2025101102      ; Serial NAIKKAN JADI 02
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

# Simpan file, lalu restart BIND9 di Tirion.
service bind9 restart

# ================ Mengatur Ulang Resolver (di 10 Host Non-Router) ================
nano /etc/resolv.conf
# Ubah isinya menjadi seperti berikut:
nameserver 192.214.3.3  # IP Tirion (ns1)
nameserver 192.214.3.4  # IP Valmar (ns2)
nameserver 192.168.122.1 # Resolver cadangan
# Ulangi langkah ini untuk 9 host lainnya: Elwing, Cirdan, Elrond, Maglor, Sirion, Tirion, Valmar, Lindon, dan Vingilot.

#  =========== Uji Coba dari Setiap Host Non-Router ===========
# Di Eonwe 
# Izinkan paket dari Barat (eth0) menuju DMZ (eth2)
iptables -A FORWARD -i eth0 -o eth2 -j ACCEPT
# Izinkan paket balasan dari DMZ (eth2) menuju Barat (eth0)
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT

# DNS Records: Dari Earendil, coba ping ke salah satu nama host yang baru dibuat.
ping sirion.k06.com