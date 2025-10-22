## DI TIRION
nano /etc/bind/jarkom/k06.com

#### Ubah jadi
$TTL    604800
@       IN      SOA     ns1.k06.com. root.k06.com. (
                        2025101301      ; Serial (YYYYMMDDXX) - NAIKKAN!
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;

; ================================
;  NS RECORDS (DNS Servers)
; ================================
@       IN      NS      ns1.k06.com.
@       IN      NS      ns2.k06.com.

; ================================
;  A RECORDS (Alamat IP)
; ================================
@       IN      A       192.214.3.2     ; k06.com -> IP Sirion
ns1     IN      A       192.214.3.3     ; ns1.k06.com -> IP Tirion (Master)
ns2     IN      A       192.214.3.4     ; ns2.k06.com -> IP Valmar (Slave)

; ================================
;  HOSTNAME RECORDS
; ================================
eonwe      IN  A  192.214.1.1
earendil   IN  A  192.214.1.2
elwing     IN  A  192.214.1.3
cirdan     IN  A  192.214.2.2
elrond     IN  A  192.214.2.3
maglor     IN  A  192.214.2.4
sirion     IN  A  192.214.3.2
lindon     30  IN  A  192.214.3.50      ; IP baru untuk Lindon, TTL 30 detik
vingilot   IN  A  192.214.3.6

; ================================
;  CNAME (Alias)
; ================================
www        IN  CNAME  sirion.k06.com.
static     30  IN  CNAME  lindon.k06.com.   ; TTL 30 detik agar ikut TTL Lindon
app        IN  CNAME  vingilot.k06.com.

### DI VALMAR
ls -l /var/lib/bind/
dig @192.214.3.4 lindon.k06.com
### Output-nya harus sudah menunjuk ke 192.214.3.50.

### Cek dari klien (misal Elwing)
dig static.k06.com




