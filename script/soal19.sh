## Soal 19
### Edit File Zona di Tirion
```
nano /etc/bind/jarkom/k06.com
```
### Lalu tambahkan satu baris CNAME baru di bagian bawah file (setelah record sebelumnya seperti morgoth):
```
; Tambahan untuk soal Pelabuhan Diperluas
havens     IN  CNAME  www.k06.com.
```
### Cari baris SOA di atas:
```
@ IN SOA ns1.k06.com. root.k06.com. (
    2025101401 ; Serial
```
### Naikkan
```
2025101501 ; Serial (update untuk havens)
```
### Cek syntax
```
named-checkzone k06.com /etc/bind/jarkom/k06.com
```
### Kalau hasilnya
```
zone k06.com/IN: loaded serial 2025101501
OK
```
### Maka restart bind (ingat: di WSL pakai named langsung):
```
pkill named
named -c /etc/bind/named.conf -g &
```
### Sinkronisasi ke Slave (Valmar)
```
ls -l /var/lib/bind/k06.com
```
### Verifikasi dari Dua Klien
```
dig @192.214.3.3 havens.k06.com
```
### Hasil yang benar
```
;; ANSWER SECTION:
havens.k06.com.   604800  IN  CNAME  www.k06.com.
www.k06.com.      604800  IN  CNAME  sirion.k06.com.
sirion.k06.com.   604800  IN  A      192.214.3.2
```
### Uji akses HTTP:
```
curl http://havens.k06.com/
```
### Hasilnya harus sama seperti:
```
<h1>War of Wrath: Lindon bertahan</h1>
<a href='/app/'>Go to App</a><br><a href='/static/'>Go to Static</a><br><a href='/admin/'>Admin</a>
```
### Di Klien 2 (Earendil)
```
dig @192.214.3.3 havens.k06.com
curl http://havens.k06.com/
```

### Verifikasi Routing Aplikasi
```
curl http://havens.k06.com/app/
curl http://havens.k06.com/static/
curl -I http://havens.k06.com/admin/
```