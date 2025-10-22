# Praktikum Komunikasi Data dan Jaringan Komputer Modul 2 - K06

## Anggota Kelompok
| NRP | Nama |
|---|---|
| 5027241006 | Nabilah Anindya Paramesti |
| 5027241041 | Raya Ahmad Syarif |

---

## Daftar Isi
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)
---

## Soal 1 

Di tepi Beleriand yang porak-poranda, Eonwe merentangkan tiga jalur: Barat untuk Earendil dan Elwing, Timur untuk Círdan, Elrond, Maglor, serta pelabuhan DMZ bagi Sirion, Tirion, Valmar, Lindon, Vingilot. Tetapkan alamat dan default gateway tiap tokoh sesuai glosarium yang sudah diberikan.

### Penjelasan 
![](/images/1-topologi.png)
- **Router (Eonwë)** menjadi gerbang untuk tiga segmen:
  - **Barat**: 192.214.1.0/24 → klien **Earendil**, **Elwing** (gateway **192.214.1.1**).
  - **Timur**: 192.214.2.0/24 → klien **Círdan**, **Elrond**, **Maglor** (gateway **192.214.2.1**).
  - **DMZ**: 192.214.3.0/24 → **Sirion**, **Tirion**, **Valmar**, **Lindon**, **Vingilot** (gateway **192.214.3.1**).
- **WAN/NAT** dari Eonwë terhubung ke antarmuka `eth3` (DHCP). *(Aktivasi NAT dibahas di nomor 2.)*

#### Tabel Alamat IP & Gateway

| Node        | Antarmuka | IP Address     | Netmask           | Default Gateway   | Segmen |
|-------------|-----------|----------------|-------------------|-------------------|--------|
| **Eonwë (router)** | `eth0`    | 192.214.1.1    | 255.255.255.0     | —                 | Barat  |
|             | `eth1`    | 192.214.2.1    | 255.255.255.0     | —                 | Timur  |
|             | `eth2`    | 192.214.3.1    | 255.255.255.0     | —                 | DMZ    |
|             | `eth3`    | DHCP (WAN)     | —                 | —                 | WAN    |
| **Earendil**| `eth0`    | 192.214.1.2    | 255.255.255.0     | 192.214.1.1       | Barat  |
| **Elwing**  | `eth0`    | 192.214.1.3    | 255.255.255.0     | 192.214.1.1       | Barat  |
| **Círdan**  | `eth0`    | 192.214.2.2    | 255.255.255.0     | 192.214.2.1       | Timur  |
| **Elrond**  | `eth0`    | 192.214.2.3    | 255.255.255.0     | 192.214.2.1       | Timur  |
| **Maglor**  | `eth0`    | 192.214.2.4    | 255.255.255.0     | 192.214.2.1       | Timur  |
| **Sirion**  | `eth0`    | 192.214.3.2    | 255.255.255.0     | 192.214.3.1       | DMZ    |
| **Tirion**  | `eth0`    | 192.214.3.3    | 255.255.255.0     | 192.214.3.1       | DMZ    |
| **Valmar**  | `eth0`    | 192.214.3.4    | 255.255.255.0     | 192.214.3.1       | DMZ    |
| **Lindon**  | `eth0`    | 192.214.3.5    | 255.255.255.0     | 192.214.3.1       | DMZ    |
| **Vingilot**| `eth0`    | 192.214.3.6    | 255.255.255.0     | 192.214.3.1       | DMZ    |

> **Catatan:** Switch tidak memerlukan IP karena berfungsi sebagai perangkat Layer 2 (L2) pada topologi ini.

#### Cuplikan Konfigurasi (file `/etc/network/interfaces`)

#### Eonwe (Router)
```ini
auto eth0
iface eth0 inet static
    address 192.214.1.1
    netmask 255.255.255.0

auto eth1
iface eth1 inet static
    address 192.214.2.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.214.3.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet dhcp
```

#### Earendil (Barat)
```ini
auto eth0
iface eth0 inet static
    address 192.214.1.2
    netmask 255.255.255.0
    gateway 192.214.1.1
```

#### Elwing (Barat)
```ini
auto eth0
iface eth0 inet static
    address 192.214.1.3
    netmask 255.255.255.0
    gateway 192.214.1.1
```

#### Círdan (Timur)
```bash
auto eth0
iface eth0 inet static
    address 192.214.2.2
    netmask 255.255.255.0
    gateway 192.214.2.1
```


#### Elrond (Timur)
```bash
auto eth0
iface eth0 inet static
    address 192.214.2.3
    netmask 255.255.255.0
    gateway 192.214.2.1
```

#### Maglor (Timur)
```ini
auto eth0
iface eth0 inet static
    address 192.214.2.4
    netmask 255.255.255.0
    gateway 192.214.2.1
```

#### Sirion (DMZ)
```bash
auto eth0
iface eth0 inet static
    address 192.214.3.2
    netmask 255.255.255.0
    gateway 192.214.3.1
```

#### Tirion (DMZ)
```bash
auto eth0
iface eth0 inet static
    address 192.214.3.3
    netmask 255.255.255.0
    gateway 192.214.3.1
```

#### Valmar (DMZ)
```bash
auto eth0
iface eth0 inet static
    address 192.214.3.4
    netmask 255.255.255.0
    gateway 192.214.3.1
```

#### Lindon (DMZ)
```bash
auto eth0
iface eth0 inet static
    address 192.214.3.5
    netmask 255.255.255.0
    gateway 192.214.3.1
```

#### Vingilot (DMZ)
```bash
auto eth0
iface eth0 inet static
    address 192.214.3.6
    netmask 255.255.255.0
    gateway 192.214.3.1
```

#### Hasil Verifikasi
1. Semua node berhasil mendapatkan IP sesuai subnetnya.  
2. Setiap node dapat melakukan `ping` ke gateway (Eonwë).  
3. Komunikasi antar-segmen belum aktif (akan diaktifkan setelah routing dan NAT dikonfigurasi di nomor selanjutnya).

---
**Kesimpulan:**  
Konfigurasi jaringan telah sesuai dengan pembagian subnet dan gateway yang diminta pada soal nomor 1. Tiap segmen terhubung ke router Eonwë dengan struktur topologi yang efisien dan siap untuk pengujian konektivitas antar-subnet setelah routing dan NAT diaktifkan.

---

## Soal 2

Angin dari luar mulai berhembus ketika Eonwe membuka jalan ke awan NAT. Pastikan jalur WAN di router aktif dan NAT meneruskan trafik keluar bagi seluruh alamat internal sehingga host di dalam dapat mencapai layanan di luar menggunakan IP address.	

### Penjelasan 
Pada soal ini, Eonwe dikonfigurasi sebagai router gerbang (gateway) agar semua host di jaringan internal bisa terhubung ke internet.

Untuk melakukannya, kita menggunakan NAT (Network Address Translation). Fitur ini memungkinkan Eonwe untuk "menyamarkan" semua lalu lintas dari jaringan internal seolah-olah berasal dari alamat IP publiknya sendiri. Dengan kata lain, Eonwe bertindak sebagai perantara tunggal antara jaringan internal dan internet.

Implementasinya dilakukan dengan satu perintah iptables yang membuat aturan MASQUERADE pada interface yang terhubung ke internet (eth3).

Langkah Konfigurasi
Perintah ini dieksekusi pada Eonwe.

#### Mengatur Aturan NAT:
```bash
iptables -t nat -A POSTROUTING -o eth3 -j MASQUERADE
```

#### Verifikasi
Tes dilakukan dari klien (misalnya, Earendil) dengan ping ke alamat IP publik untuk memastikan koneksi internet berhasil.

#### Perintah Verifikasi:
```bash
ping 8.8.8.8 -c 4
```
**Hasil yang Diharapkan:** Output 0% packet loss yang menandakan bahwa paket berhasil dikirim ke internet dan balasannya diterima. Ini membuktikan Eonwe telah sukses berfungsi sebagai gerbang NAT.

---

## Soal 3

Kabar dari Barat menyapa Timur. Pastikan kelima klien dapat saling berkomunikasi lintas jalur (routing internal via Eonwe berfungsi), lalu pastikan setiap host non-router menambahkan resolver 192.168.122.1 saat interfacenya aktif agar akses paket dari internet tersedia sejak awal.

### Penjelasan

Penjelasan
Soal ini memiliki dua tujuan utama. Pertama, memverifikasi fungsi Eonwe sebagai router internal. Kita harus memastikan bahwa host dari jaringan yang berbeda (misalnya, Jaringan Barat dan Jaringan Timur) dapat saling berkomunikasi. Ini membuktikan bahwa Eonwe berhasil meneruskan paket data antar jaringan yang terhubung dengannya.

Kedua, mengatur resolusi DNS awal. Semua host non-router perlu diberi tahu alamat server DNS sementara (192.168.122.1, DNS bawaan GNS3). Tujuannya adalah agar host-host tersebut bisa menerjemahkan nama domain (seperti archive.ubuntu.com) menjadi alamat IP, yang merupakan syarat wajib untuk bisa mengunduh paket atau update dari internet.

### Langkah-langkah Pengerjaan

1. **Konfigurasi Resolver Awal**  
Langkah ini dilakukan pada semua 10 host non-router.

**Mengedit file `/etc/resolv.conf`:** File `/etc/resolv.conf` pada setiap host (selain Eonwe) diisi dengan satu baris berikut untuk menunjuk ke DNS server GNS3.

```bash
# Contoh di Earendil
nano /etc/resolv.conf
```
**Isi file:**
```
nameserver 192.168.122.1
```

### Verifikasi

1. **Verifikasi Routing Internal**  
Dilakukan tes ping dari klien di Jaringan Barat (Earendil) ke klien di Jaringan Timur (Cirdan).

**Perintah Verifikasi di Earendil:**

```bash
ping 192.214.2.2 -c 4
```
**Hasil yang Diharapkan:** Output 0% packet loss yang menandakan Eonwe berhasil merutekan paket antar jaringan.

```
PING 192.214.2.2 (192.214.2.2) 56(84) bytes of data.
64 bytes from 192.214.2.2: icmp_seq=1 ttl=63 time=... ms
...
--- 192.214.2.2 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, ...
```

2. **Verifikasi Resolver**  
Dilakukan tes ping ke nama domain publik dari salah satu klien untuk memastikan DNS resolver bekerja.

**Perintah Verifikasi di Earendil:**

```bash
ping google.com -c 4
```
---

## Soal 4

Para penjaga nama naik ke menara, di Tirion (ns1/master) bangun zona <xxxx>.com sebagai authoritative dengan SOA yang menunjuk ke ns1.<xxxx>.com dan catatan NS untuk ns1.<xxxx>.com dan ns2.<xxxx>.com. Buat A record untuk ns1.<xxxx>.com dan ns2.<xxxx>.com yang mengarah ke alamat Tirion dan Valmar sesuai glosarium, serta A record apex <xxxx>.com yang mengarah ke alamat Sirion (front door), aktifkan notify dan allow-transfer ke Valmar, set forwarders ke 192.168.122.1. Di Valmar (ns2/slave) tarik zona <xxxx>.com dari Tirion dan pastikan menjawab authoritative. pada seluruh host non-router ubah urutan resolver menjadi IP dari ns1.<xxxx>.com → ns2.<xxxx>.com → 192.168.122.1. Verifikasi query ke apex dan hostname layanan dalam zona dijawab melalui ns1/ns2.

### Penjelasan 

Pada soal ini, Anda membangun infrastruktur DNS authoritative untuk domain **k06.com** dengan arsitektur **Master–Slave** agar resolusi nama tetap andal saat salah satu server bermasalah.

#### 1) Tirion (ns1/master)

**Instalasi & direktori**
```bash
apt-get update && apt-get install -y bind9
mkdir -p /etc/bind/jarkom
```

**/etc/bind/named.conf.local** — deklarasi zona master, izinkan transfer ke Valmar, dan kirim NOTIFY:
```conf
zone "k06.com" {
    type master;
    file "/etc/bind/jarkom/k06.com";
    allow-transfer { 192.214.3.4; };   // IP Valmar (ns2)
    also-notify    { 192.214.3.4; };   // Kirim NOTIFY ke Valmar
};
```

**/etc/bind/named.conf.options** — tambahkan forwarder untuk domain eksternal:
```conf
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    // (opsional) dnssec-validation auto;
    listen-on-v6 { any; };
};
```

**/etc/bind/jarkom/k06.com** — zone file authoritative:
```dns
$TTL 604800
@   IN  SOA ns1.k06.com. root.k06.com. (
        2025101101  ; Serial (YYYYMMDDNN)
        604800      ; Refresh
        86400       ; Retry
        2419200     ; Expire
        604800 )    ; Negative Cache TTL
;

; Name servers
@       IN  NS  ns1.k06.com.
@       IN  NS  ns2.k06.com.

; Apex (front door → Sirion)
@       IN  A   192.214.3.2       ; k06.com → IP Sirion

; Name server addresses
ns1     IN  A   192.214.3.3       ; Tirion
ns2     IN  A   192.214.3.4       ; Valmar
```

**Restart layanan**
```bash
systemctl restart bind9
systemctl status bind9 --no-pager
```

#### 2) Valmar (ns2/slave)

**Instalasi**
```bash
apt-get update && apt-get install -y bind9
```

**/etc/bind/named.conf.local** — tarik zona dari master:
```conf
zone "k06.com" {
    type slave;
    masters { 192.214.3.3; };      // IP Tirion (ns1/master)
    file "/var/lib/bind/k06.com";  // Bind akan mengisi otomatis
};
```

**Restart layanan**
```bash
systemctl restart bind9
systemctl status bind9 --no-pager
```

#### 3) Penataan resolver di seluruh host non-router

Setelah DNS internal hidup, ubah urutan resolver menjadi:
```
nameserver 192.214.3.3   # ns1.k06.com (Tirion)
nameserver 192.214.3.4   # ns2.k06.com (Valmar)
nameserver 192.168.122.1 # fallback
```
Simpan cara pengaturan sesuai distro (mis. `/etc/resolv.conf` sementara, atau permanen via netplan/interfaces/NetworkManager).

#### 4) Verifikasi

**Apex ke Master (ns1/Tirion)**
```bash
dig @192.214.3.3 k06.com +noall +answer +authority +additional
```
Contoh keluaran yang diharapkan (ringkas):
```
k06.com. 604800 IN A 192.214.3.2
```
Flag **aa** (authoritative answer) menandakan jawaban otoritatif dari master.

**Apex ke Slave (ns2/Valmar)**
```bash
dig @192.214.3.4 k06.com +noall +answer +authority +additional
```
Keluaran harus identik pada **ANSWER SECTION** dan memuat flag **aa** juga—ini membuktikan zone transfer sukses.

**NS & glue check**
```bash
dig @192.214.3.3 NS k06.com +noall +answer
dig @192.214.3.4 NS k06.com +noall +answer
```
Harus menampilkan **ns1.k06.com** dan **ns2.k06.com**, dan query A untuk **ns1/ns2** mengarah ke **192.214.3.3/192.214.3.4**.

**Forwarder eksternal (sanity check)**
```bash
dig @192.214.3.3 google.com A +short
dig @192.214.3.4 google.com A +short
```
Jika alamat IP publik Google muncul, forwarder berfungsi.

---


## Soal 5

“Nama memberi arah,” kata Eonwe. Namai semua tokoh (hostname) sesuai glosarium, eonwe, earendil, elwing, cirdan, elrond, maglor, sirion, tirion, valmar, lindon, vingilot, dan verifikasi bahwa setiap host mengenali dan menggunakan hostname tersebut secara system-wide. Buat setiap domain untuk masing masing node sesuai dengan namanya (contoh: eru.<xxxx>.com) dan assign IP masing-masing juga. Lakukan pengecualian untuk node yang bertanggung jawab atas ns1 dan ns2

### Penjelasan

Penjelasan
Pada soal ini, kita melakukan tiga langkah konfigurasi fundamental untuk membuat jaringan kita lebih terstruktur, fungsional, dan terpusat.

**Pengaturan Hostname:** Setiap node dalam topologi diberi nama yang unik dan deskriptif (misalnya, eonwe, earendil) untuk menggantikan nama generik. Ini membuat identifikasi dan pengelolaan setiap mesin di dalam jaringan menjadi jauh lebih mudah dan intuitif.

**Pendaftaran A Record di DNS:** Nama-nama hostname yang baru kemudian didaftarkan sebagai A Record di server DNS Master (Tirion). Ini adalah langkah krusial untuk manajemen nama terpusat. Dengan mendaftarkannya di DNS, semua host di jaringan dapat menerjemahkan nama host (misalnya, sirion.k06.com) menjadi alamat IP-nya (192.214.3.2) hanya dengan bertanya ke server DNS, tanpa perlu menyimpan catatan di setiap mesin.

**Mengalihkan Resolver Klien:** Langkah terakhir adalah mengkonfigurasi ulang semua host non-router untuk menggunakan server DNS internal kita (Tirion dan Valmar) sebagai pilihan utama. Dengan mengubah file /etc/resolv.conf, kita "mengaktifkan" sistem DNS yang telah kita bangun. Mulai dari titik ini, semua permintaan resolusi nama akan ditangani oleh server kita sendiri, membuat jaringan lebih mandiri dan efisien. DNS eksternal (192.168.122.1) dipertahankan sebagai cadangan.

Secara keseluruhan, soal ini mengubah jaringan kita dari sekumpulan mesin yang hanya saling kenal lewat alamat IP menjadi sebuah sistem yang terorganisir di mana setiap mesin memiliki nama yang dikenali oleh semua.

### Langkah-langkah Konfigurasi

1. **Mengatur Hostname**  
Pada setiap node, dua perintah dijalankan untuk mengubah nama host baik untuk sesi ini maupun secara permanen.

```bash
# Contoh di Earendil
hostname earendil
echo "earendil" > /etc/hostname
```

2. **Menambahkan A Record di Tirion**  
File zona `/etc/bind/jarkom/k06.com` di Tirion diperbarui dengan menambahkan A Record untuk setiap host dan menaikkan nomor serialnya menjadi ...02.

```dns
; Hostnames
eonwe    IN      A       192.214.1.1
earendil IN      A       192.214.1.2
elwing   IN      A       192.214.1.3
cirdan   IN      A       192.214.2.2
elrond   IN      A       192.214.2.3
maglor   IN      A       192.214.2.4
sirion   IN      A       192.214.3.2
lindon   IN      A       192.214.3.5
vingilot IN      A       192.214.3.6
```
Setelah itu, layanan bind9 di-restart.

3. **Mengatur Ulang Resolver**  
File `/etc/resolv.conf` pada 10 host non-router diubah isinya menjadi:

```conf
nameserver 192.214.3.3  # IP Tirion (ns1)
nameserver 192.214.3.4  # IP Valmar (ns2)
nameserver 192.168.122.1 # Resolver cadangan
```

### Verifikasi

Verifikasi dilakukan dari klien (Earendil) dengan melakukan ping ke salah satu hostname yang baru didaftarkan.

```bash
ping sirion.k06.com -c 4
```
**Hasil yang Diharapkan:**

```
PING sirion.k06.com (192.214.3.2) 56(84) bytes of data.
64 bytes from 192.214.3.2: icmp_seq=1 ttl=63 time=... ms
...
--- sirion.k06.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, ...
```
Hasil ping ke alamat IP internal yang benar (192.214.3.2) membuktikan bahwa klien berhasil menggunakan DNS internal untuk me-resolve nama host dan terhubung ke server yang dituju.

---

## Soal 6

Lonceng Valmar berdentang mengikuti irama Tirion. Pastikan zone transfer berjalan, Pastikan Valmar (ns2) telah menerima salinan zona terbaru dari Tirion (ns1). Nilai serial SOA di keduanya harus sama

### Penjelasan
Soal ini bertujuan untuk memverifikasi bahwa mekanisme sinkronisasi antara DNS Master (Tirion) dan DNS Slave (Valmar) berjalan dengan sukses. Proses ini dikenal sebagai zone transfer.

Ketika kita melakukan perubahan pada zone file di Tirion (seperti menambahkan A Record di Soal 5) dan menaikkan nomor serial SOA, Tirion akan memberitahu Valmar bahwa ada data baru. Valmar kemudian akan meminta salinan data terbaru tersebut.

Bukti utama bahwa proses ini berhasil adalah nilai serial SOA yang identik di kedua server. Ini memastikan bahwa Valmar selalu memiliki data yang sinkron dan siap berfungsi sebagai cadangan jika Tirion mengalami masalah.

### Langkah-langkah Verifikasi

Verifikasi dilakukan dengan membandingkan nomor serial SOA langsung dari kedua server menggunakan perintah dig.

1. **Cek Nomor Serial di Tirion (Master)**  
Dari terminal Tirion, kueri diajukan ke layanan DNS lokal (@localhost) untuk melihat SOA record dari zona k06.com.

**Perintah di Tirion:**

```bash
dig @localhost soa k06.com
```
**Output yang Diharapkan:** Perhatikan ANSWER SECTION. Nomor serial yang ditampilkan harus sesuai dengan nomor terakhir yang diatur (misalnya, 2025101102 dari Soal 5).

```
;; ANSWER SECTION:
k06.com.    604800  IN  SOA   ns1.k06.com. root.k06.com. 2025101102 ...
```

2. **Cek Nomor Serial di Valmar (Slave)**  
Langkah yang sama diulangi di terminal Valmar.

**Perintah di Valmar:**

```bash
dig @localhost soa k06.com
```
**Output yang Diharapkan:** Nomor serial pada ANSWER SECTION harus sama persis dengan yang ada di Tirion.

```
;; ANSWER SECTION:
k06.com.    604800  IN  SOA   ns1.k06.com. root.k06.com. 2025101102 ...
```

### Kesimpulan

Karena nilai serial SOA di Tirion dan Valmar terbukti identik, maka dapat disimpulkan bahwa zone transfer telah berhasil. Konfigurasi Master-Slave DNS berfungsi sebagaimana mestinya.


---

## Soal 7

Peta kota dan pelabuhan dilukis. Sirion sebagai gerbang, Lindon sebagai web statis, Vingilot sebagai web dinamis. Tambahkan pada zona <xxxx>.com A record untuk sirion.<xxxx>.com (IP Sirion), lindon.<xxxx>.com (IP Lindon), dan vingilot.<xxxx>.com (IP Vingilot). Tetapkan CNAME :
www.<xxxx>.com → sirion.<xxxx>.com, 
static.<xxxx>.com → lindon.<xxxx>.com, dan 
app.<xxxx>.com → vingilot.<xxxx>.com. 
Verifikasi dari dua klien berbeda bahwa seluruh hostname tersebut ter-resolve ke tujuan yang benar dan konsisten.

### Penjelasan

Inti dari soal ini adalah untuk membuktikan bahwa **Valmar (Slave)** sudah secara otomatis menyalin semua perubahan yang kita buat di **Tirion (Master)** pada soal-soal sebelumnya (seperti saat kita menambahkan hostname di Soal 5).

Proses penyalinan data ini disebut **zone transfer**. Bayangkan **Tirion** memegang "dokumen asli" dan **Valmar** memegang "salinan fotokopi"-nya.

Nomor **Serial SOA** adalah seperti nomor versi atau tanggal revisi pada dokumen.

Ketika kita mengedit zone file di Tirion dan menaikkan nomor serialnya, Valmar akan melihat bahwa versi "dokumen asli" lebih baru daripada salinannya.

Valmar kemudian akan secara otomatis meminta salinan data terbaru dari Tirion.

Bukti utama bahwa proses ini berhasil adalah **nilai serial SOA yang identik** di kedua server. Ini memastikan bahwa Valmar selalu memiliki data yang sinkron dan siap berfungsi sebagai cadangan jika Tirion mengalami masalah. 🛡️

### Langkah-langkah Pengerjaan

Kita akan menggunakan perintah **dig** untuk memeriksa SOA record di masing-masing server secara langsung.

#### 1. Cek Nomor Serial di Tirion (Master)
Buka terminal di Tirion.

Jalankan perintah **dig** untuk menanyakan SOA record ke server itu sendiri (localhost):

```bash
dig @localhost soa k06.com
```

Perhatikan bagian **ANSWER SECTION**. Anda akan melihat baris SOA dengan nomor serial terakhir yang Anda atur (misalnya, 2025101102 dari Soal 5).

**Contoh Output di Tirion:**
```
;; ANSWER SECTION:
k06.com.    604800  IN  SOA   ns1.k06.com. root.k06.com. 2025101102 ...
```

#### 2. Cek Nomor Serial di Valmar (Slave)
Buka terminal di Valmar.

Jalankan perintah yang sama untuk menanyakan SOA record ke server itu sendiri:

```bash
dig @localhost soa k06.com
```

Perhatikan **ANSWER SECTION**. Jika zone transfer berhasil, Anda akan melihat nomor serial yang sama persis dengan yang ada di Tirion.

**Contoh Output di Valmar:**
```
;; ANSWER SECTION:
k06.com.    604800  IN  SOA   ns1.k06.com. root.k06.com. 2025101102 ...
```

### Kesimpulan

Jika nomor serial pada output di Tirion dan Valmar **SAMA**, maka Anda telah berhasil membuktikan bahwa **zone transfer berjalan dengan sukses**. ✅  

Ini menandakan bahwa sistem DNS Anda sudah **resilient**, di mana server cadangan (**Valmar**) selalu memiliki data yang sinkron dengan server utama (**Tirion**).


---

## Soal 8

Setiap jejak harus bisa diikuti. Di Tirion (ns1) deklarasikan satu reverse zone untuk segmen DMZ tempat Sirion, Lindon, Vingilot berada. Di Valmar (ns2) tarik reverse zone tersebut sebagai slave, isi PTR untuk ketiga hostname itu agar pencarian balik IP address mengembalikan hostname yang benar, lalu pastikan query reverse untuk alamat Sirion, Lindon, Vingilot dijawab authoritative.

### Penjelasan

Pada soal ini, kita akan mengkonfigurasi Reverse DNS Zone. Tujuannya adalah untuk bisa melakukan pencarian nama host berdasarkan alamat IP-nya.

Forward Zone (yang sudah kita buat): Bertanya, "Apa alamat IP dari sirion.k06.com?" -> Dijawab: 192.214.3.2.

Reverse Zone (yang akan kita buat): Bertanya, "Siapa nama pemilik alamat IP 192.214.3.2?" -> Dijawab: sirion.k06.com.

Ini diimplementasikan dengan membuat sebuah zone baru dengan nama khusus yang dibentuk dari alamat jaringan yang dibalik (untuk 192.214.3.0/24, namanya menjadi 3.214.192.in-addr.arpa) dan mengisinya dengan PTR (Pointer) Record. Sama seperti sebelumnya, Tirion akan menjadi Master dan Valmar menjadi Slave untuk zona ini.

### Langkah-langkah Konfigurasi

**Bagian 1: Konfigurasi di Tirion (DNS Master)**  
Lakukan semua langkah ini di terminal Tirion.

**Deklarasikan Reverse Zone:** Buka file `named.conf.local` untuk mendaftarkan zone baru kita.

```bash
nano /etc/bind/named.conf.local
```
Tambahkan blok zone baru ini di bawah zone k06.com yang sudah ada.
```conf
// Tambahkan ini di bawah zone "k06.com"
zone "3.214.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.214.192.in-addr.arpa";
    allow-transfer { 192.214.3.4; }; // IP Valmar
    also-notify { 192.214.3.4; };    // IP Valmar
};
```

**Buat File Zone untuk Reverse Lookup:** Sekarang kita buat file "peta terbalik"-nya.

```bash
nano /etc/bind/jarkom/3.214.192.in-addr.arpa
```
Isi file tersebut dengan konfigurasi berikut. Perhatikan bahwa kita hanya perlu menulis angka terakhir dari alamat IP untuk PTR record.
```dns
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
2       IN      PTR     sirion.k06.com.   ; untuk IP 192.214.3.2
5       IN      PTR     lindon.k06.com.   ; untuk IP 192.214.3.5
6       IN      PTR     vingilot.k06.com. ; untuk IP 192.214.3.6
```

**Cek Konfigurasi dan Restart:**

```bash
named-checkconf
named-checkzone 3.214.192.in-addr.arpa /etc/bind/jarkom/3.214.192.in-addr.arpa

# Jika kedua perintah di atas tidak error (atau checkzone OK), restart BIND9
service bind9 restart
```

**Bagian 2: Konfigurasi di Valmar (DNS Slave)**  
Lakukan langkah ini di terminal Valmar.

**Deklarasikan Reverse Zone sebagai Slave:**

```bash
nano /etc/bind/named.conf.local
```
Tambahkan blok zone ini di bawah zone k06.com yang sudah ada.
```conf
// Tambahkan ini di bawah zone "k06.com"
zone "3.214.192.in-addr.arpa" {
    type slave;
    masters { 192.214.3.3; }; // IP Tirion
    file "/var/lib/bind/3.214.192.in-addr.arpa";
};
```

**Restart BIND9:**

```bash
service bind9 restart
```

### Verifikasi

Buka terminal di salah satu klien (misalnya, Earendil) dan gunakan perintah `dig -x` untuk melakukan reverse lookup.

**Cek IP Sirion (192.214.3.2):**

```bash
dig -x 192.214.3.2
```
Perhatikan ANSWER SECTION. Anda akan melihat PTR record yang menunjuk ke sirion.k06.com.. Statusnya harus NOERROR dan flag-nya harus aa (authoritative answer).

**Cek IP Lindon (192.214.3.5):**

```bash
dig -x 192.214.3.5
```
Hasilnya harus menunjuk ke lindon.k06.com..

**Cek IP Vingilot (192.214.3.6):**

```bash
dig -x 192.214.3.6
```
Hasilnya harus menunjuk ke vingilot.k06.com..

---

## Soal 9

Lampion Lindon dinyalakan. Jalankan web statis pada hostname static.<xxxx>.com dan buka folder arsip /annals/ dengan autoindex (directory listing) sehingga isinya dapat ditelusuri. Akses harus dilakukan melalui hostname, bukan IP.

### Penjelasan
Pada soal ini, kita akan mengkonfigurasi Nginx di **Lindon** agar menjadi server web khusus untuk alamat **static.k06.com**. Konfigurasi ini disebut **virtual host**, yang memungkinkan satu server fisik untuk menjadi "rumah" bagi banyak nama domain.

Kita juga akan mengaktifkan fitur **autoindex** untuk direktori **/annals/**. Fitur ini sangat berguna dan akan secara otomatis menampilkan daftar file yang ada di dalam sebuah direktori jika tidak ada file `index.html` di dalamnya, persis seperti saat Anda menjelajahi folder di manajer file komputer Anda. 📂

### Langkah-langkah Konfigurasi

Semua konfigurasi berikut dilakukan di terminal **Lindon**.

**Langkah 1: Buat Direktori dan File Contoh**  
Kita siapkan dulu direktorinya agar memiliki isi untuk ditampilkan.

```bash
# Di terminal Lindon
# Buat direktori /annals/ di dalam web root
mkdir -p /var/www/html/annals

# Buat beberapa file kosong sebagai contoh
touch /var/www/html/annals/file_penting.txt
touch /var/www/html/annals/dokumen_revisi.docx
```

**Langkah 2: Konfigurasi Virtual Host Nginx**  
Kita akan membuat file konfigurasi baru yang spesifik untuk **static.k06.com**.

**Buat file konfigurasi baru:**

```bash
# Di terminal Lindon
nano /etc/nginx/sites-available/static.k06.com
```
**Isi file konfigurasi:** Salin dan tempel konfigurasi berikut ke dalam file tersebut.

```nginx
server {
    listen 80;

    # Tentukan web root
    root /var/www/html;
    index index.html index.htm;

    # Server ini hanya akan merespon untuk hostname static.k06.com
    server_name static.k06.com;

    # Konfigurasi khusus untuk direktori /annals/
    location /annals/ {
        # Aktifkan directory listing (autoindex)
        autoindex on;
    }
}
```

**Langkah 3: Aktifkan Virtual Host Baru**  
Nginx perlu tahu untuk menggunakan konfigurasi baru kita dan mengabaikan yang default.

**Hapus link konfigurasi default:**

```bash
# Di terminal Lindon
rm /etc/nginx/sites-enabled/default
```
**Buat link untuk konfigurasi baru kita:**

```bash
# Di terminal Lindon
ln -s /etc/nginx/sites-available/static.k06.com /etc/nginx/sites-enabled/
```

**Langkah 4: Cek Sintaks dan Restart Nginx**  
Pastikan tidak ada salah ketik sebelum me-restart.

```bash
# Di terminal Lindon
nginx -t
```
Jika outputnya menunjukkan **syntax is ok** dan **test is successful**, restart Nginx untuk menerapkan perubahan:

```bash
# Di terminal Lindon
service nginx restart
```

### Verifikasi

Buka terminal di salah satu klien (misalnya, **Earendil**) dan gunakan **curl** untuk mengakses alamat `http://static.k06.com/annals/`.

```bash
# Di terminal Earendil
curl http://static.k06.com/annal
```

---

## Soal 10

Vingilot mengisahkan cerita dinamis. Jalankan web dinamis (PHP-FPM) pada hostname app.<xxxx>.com dengan beranda dan halaman about, serta terapkan rewrite sehingga /about berfungsi tanpa akhiran .php. Akses harus dilakukan melalui hostname.

### Penjelasan 
Pada soal ini, kita akan mengkonfigurasi **Vingilot** sebagai server web dinamis yang secara khusus melayani hostname **app.k06.com**.  
Ini dicapai dengan membuat **virtual host** di **Nginx**, sebuah teknik yang memungkinkan satu server fisik untuk menjadi "rumah" bagi banyak situs web yang berbeda.

Tujuannya adalah untuk menyajikan sebuah situs sederhana yang dibuat dengan **PHP** dan menerapkan **URL Rewrite**.  
Fitur ini sangat penting dalam pengembangan web modern karena memungkinkan kita untuk membuat URL yang bersih dan ramah pengguna (misalnya, `app.k06.com/about` daripada `app.k06.com/about.php`).

Selain itu, konfigurasi **Nginx** diperketat untuk meningkatkan keamanan. Sebuah **server block default** dibuat untuk menolak semua koneksi yang tidak secara eksplisit ditujukan untuk `app.k06.com`, seperti akses melalui alamat IP langsung.  
Ini memastikan bahwa situs hanya dapat diakses melalui nama domain yang benar.

---

### Langkah-langkah Konfigurasi

Berikut adalah penjelasan untuk setiap bagian dari skrip pengerjaan Anda:

#### 1. Instalasi & Aktivasi Layanan

```bash
apt install nginx php php-fpm -y
```
Perintah ini menginstal semua perangkat lunak yang dibutuhkan: **Nginx** sebagai server web, dan **PHP-FPM (FastCGI Process Manager)** sebagai layanan yang akan mengeksekusi kode PHP.

```bash
service nginx start
service php8.4-fpm start
```
Memastikan kedua layanan (**Nginx** dan **PHP-FPM**) berjalan setelah instalasi.

---

#### 2. Pembuatan Konten Situs

```bash
mkdir -p /var/www/app.k06.com
```
Membuat direktori baru yang terisolasi khusus untuk file-file situs `app.k06.com`. Ini adalah praktik terbaik untuk **virtual hosting**.

```bash
nano /var/www/app.k06.com/index.php
nano /var/www/app.k06.com/about.php
```
Membuat dua file PHP sederhana. `index.php` akan menjadi halaman beranda, dan `about.php` akan menjadi halaman "Tentang Kami".

---

#### 3. Konfigurasi Virtual Host Nginx

Ini adalah inti dari pengerjaan. File `/etc/nginx/sites-available/app.k06.com` dibuat dengan **dua blok server**.

##### Blok Server Default

```nginx
server {
    listen 80 default_server;
    server_name _;
    return 403;
}
```
Blok ini bertindak sebagai **penangkap semua**.  
`default_server` membuatnya menangani semua permintaan yang tidak cocok dengan `server_name` lain, seperti saat diakses via IP.  
Perintah `return 403;` secara langsung menolak koneksi tersebut.

##### Blok Server app.k06.com

```nginx
server {
    listen 80;
    server_name app.k06.com;
    root /var/www/app.k06.com;

    # Aturan URL Rewrite
    rewrite ^/about$ /about.php last;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }

    location / {
        try_files $uri $uri/ =404;
    }
}
```
Blok ini hanya akan merespons jika hostname yang diminta adalah **app.k06.com**.  
Di dalamnya terdapat aturan `rewrite ^/about$ /about.php last;` yang "menulis ulang" permintaan `/about` menjadi `/about.php` secara internal.  
Selain itu, blok `location ~ \.php$ { ... }` memberi tahu Nginx bahwa setiap file berakhiran `.php` harus diteruskan ke **php8.4-fpm** untuk dieksekusi.

---

#### 4. Aktivasi Situs

```bash
ln -s /etc/nginx/sites-available/app.k06.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
```
Perintah di atas mengaktifkan konfigurasi virtual host **app.k06.com** dan menonaktifkan konfigurasi default Nginx.

```bash
nginx -t
service nginx reload
```
`nginx -t` digunakan untuk memeriksa apakah ada kesalahan sintaks dalam konfigurasi, kemudian `service nginx reload` memuat ulang konfigurasi tanpa menghentikan layanan.

---

### Verifikasi

Verifikasi dilakukan dari klien (contoh: **Earendil**) untuk mensimulasikan akses pengguna sungguhan.

```bash
ping app.k06.com
```
Memastikan DNS dan konektivitas jaringan dasar berfungsi.

```bash
curl http://app.k06.com/
```
Menguji apakah halaman utama berhasil diakses.

```bash
curl http://app.k06.com/about
```
Menguji apakah aturan **URL Rewrite** berfungsi dengan benar.

```bash
curl http://192.214.3.6/
```
Menguji apakah blok server default berhasil memblokir akses via IP langsung, sesuai dengan persyaratan keamanan.

## Soal 11
Di muara sungai, Sirion berdiri sebagai reverse proxy. Terapkan path-based routing: /static → Lindon dan /app → Vingilot, sambil meneruskan header Host dan X-Real-IP ke backend. Pastikan Sirion menerima www.<xxxx>.com (kanonik) dan sirion.<xxxx>.com, dan bahwa konten pada /static dan /app di-serve melalui backend yang tepat.

### Penjelasan
Soal nomor 11 membahas konfigurasi reverse proxy menggunakan Nginx pada server Sirion. Dalam skenario ini, Sirion berfungsi sebagai gerbang yang meneruskan permintaan pengguna ke dua server backend berbeda berdasarkan jalur akses. Permintaan dengan path /static diteruskan ke server Lindon yang menyediakan konten statis, sedangkan path /app diteruskan ke server Vingilot yang menjalankan aplikasi dinamis berbasis PHP. Header Host dan X-Real-IP diteruskan agar backend tetap mengetahui hostname dan alamat IP asli pengguna. Selain itu, Sirion dikonfigurasi untuk menerima domain www.k06.com dan sirion.k06.com, sehingga seluruh permintaan melalui hostname tersebut diatur dan diarahkan ke layanan yang sesuai.

### Langkah-langkah konfigurasi
### 1. Buka node sirion dan lakukan command berikut:
   ```bash
    apt update
    apt install nginx -y
   ```
### 2. Buat Konfigurasi situs di reverse proxy
   ```bash
   nano /etc/nginx/sites-available/www.k06.com
   ```
   
   Isi dengan konfigurasi berikut
   ```bash
    server {
    listen 80;
    server_name www.k06.com sirion.k06.com;

    # Forward /static ke Lindon (web statis)
    location /static/ {
        proxy_pass http://192.214.3.5/;  # Lindon
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot (web dinamis)
    location /app/ {
        proxy_pass http://192.214.3.6/;  # Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Halaman utama di Sirion
    location / {
        return 200 "<h1>War of Wrath: Lindon bertahan</h1><a href='/app/'>Go to App</a><br><a href='/static/'>Go to Static</a>";
        add_header Content-Type text/html;
    }
   }
   ```
### 3. Pada node vingilot lakukan ini:
```bash
    nano /etc/nginx/sites-available/www.k06.com
```

```bash
  server {
    listen 80 default_server;
    server_name app.k06.com www.k06.com;
    root /var/www/app.k06.com;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location /about {
        rewrite ^/about$ /about.php last;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
```
### 4. Pada node Lindon lakukan ini
```bash
   nano /etc/nginx/sites-available/www.k06.com
```

```bash
server {
    listen 80 default_server;
    server_name static.k06.com www.k06.com;
    root /var/www/html;
    index index.html index.htm;

    # Folder annals dengan autoindex
    location /annals/ {
        autoindex on;
    }

    # Optional: tampilkan pesan kalau index tidak ada
    location / {
        try_files $uri $uri/ =404;
    }
}
```

### 5. Aktifkan situs dan reload Nginx

```bash
ln -s /etc/nginx/sites-available/www.k06.com /etc/nginx/sites-enabled/
nginx -t
nginx -s reload
```

### 6. Uji Coba dari klien contohnya Elrond:
Pastikan terlebih dahulu klien pakai DNS internal (/etc/resolv.conf mengarah ke 192.214.3.3 dan 192.214.3.4).
```bash
curl http://www.k06.com/
curl http://www.k06.com/static/
curl http://www.k06.com/app/
```
![WhatsApp Image 2025-10-20 at 16 58 47_37abdf78](https://github.com/user-attachments/assets/f354dcd0-346c-4461-b342-58a5c30cac3f)  

![WhatsApp Image 2025-10-20 at 16 20 21_6b93070a](https://github.com/user-attachments/assets/2324c44b-f496-4d50-9f43-ca7e64baecdc)  

## Soal 12
Ada kamar kecil di balik gerbang yakni /admin. Lindungi path tersebut di Sirion menggunakan Basic Auth, akses tanpa kredensial harus ditolak dan akses dengan kredensial yang benar harus diizinkan.

### Penjelasan
Soal ini berfokus pada penerapan **Basic Authentication (Basic Auth)** di server Sirion menggunakan Nginx untuk melindungi path `/admin`. Artinya, ketika pengguna mencoba mengakses halaman `/admin`, server akan meminta kredensial (username dan password) sebelum mengizinkan akses. Jika pengguna tidak memberikan kredensial atau memberikan data yang salah, akses akan ditolak (HTTP 401 Unauthorized), sementara jika kredensialnya benar, halaman akan terbuka (HTTP 200 OK). Konfigurasi ini biasanya dilakukan dengan menambahkan direktif `auth_basic` dan `auth_basic_user_file` di blok `location /admin/`, serta membuat file `.htpasswd` berisi username dan password terenkripsi sebagai daftar pengguna yang diizinkan.

### Langkah-langkah konfigurasi
### 1. Buka node sirion dan lakukan command berikut:
   ```bash
     apt install apache2-utils -y
   ```
### 2. Buat file password pada direktori berikut dan ketik password (misal: komdat25):  
   ```bash
     htpasswd -c /etc/nginx/.htpasswd admin
   ```
### 3. Edit konfigurasi Nginx
   ```bash
     nano /etc/nginx/sites-available/www.k06.com
   ```
  Tambah code berikut ini:
     ```
     
    server {
    listen 80;
    server_name www.k06.com sirion.k06.com;

    # Forward /static ke Lindon (web statis)
    location /static/ {
        proxy_pass http://192.214.3.5/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot (web dinamis)
    location /app/ {
        proxy_pass http://192.214.3.6/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Area admin (terpisah, tidak di dalam /static)
    location /admin/ {
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;
        root /var/www/html;
        index index.html;
    }

    # Halaman utama di Sirion
    location / {
        return 200 "<h1>War of Wrath: Lindon bertahan</h1>
        <a href='/app/'>Go to App</a><br>
        <a href='/static/'>Go to Static</a><br>
        <a href='/admin/'>Admin</a>";
        add_header Content-Type text/html;
       }
    }
    

### 4. Buat file html admin
```
  
mkdir -p /var/www/html/admin
echo "<h1>Welcome, Administrator</h1>" > /var/www/html/admin/index.html
```
### 5. Tes Konfigurasi dan reload nginx
```
nginx -t
```
### Kalau hasilnya:
```
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
### Maka:
```
nginx -s reload
```
### 6. Tes dari client (misal Elwing)
# Tanpa login
curl -i http://www.k06.com/admin/
#Hasil:
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Basic realm="Restricted Area"

### Login yang benar:
```
curl -i -u admin:komdat25 http://www.k06.com/admin/
```

### Hasil:
```
HTTP/1.1 200 OK
<h1>Welcome, Administrator</h1>
```


---

## 13. Soal 13

### 1. Edit Konfigurasi di Sirion
```

# Tambahkan berikut:
# ===============================
# 1. REDIRECT SERVER BLOCK
# ===============================
server {
    listen 80;
    server_name 192.214.3.2 sirion.k06.com;

    # Redirect semua request ke nama kanonik
    return 301 http://www.k06.com$request_uri;
}

# ===============================
# 2. MAIN SERVER (KANONIK)
# ===============================
server {
    listen 80;
    server_name www.k06.com;

    # Forward /static ke Lindon
    location /static/ {
        proxy_pass http://192.214.3.5/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Forward /app ke Vingilot
    location /app/ {
        proxy_pass http://192.214.3.6/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Halaman utama
    location / {
        default_type text/html;
        return 200 "<h1>War of Wrath: Lindon bertahan</h1>
        <a href='/app/'>Go to App</a><br>
        <a href='/static/'>Go to Static</a><br>
        <a href='/admin/'>Admin</a>";
    }

    # Admin area (dilindungi)
    location = /admin {
        return 301 /admin/;
    }

    location /admin/ {
        auth_basic "Restricted Area";
        auth_basic_user_file /etc/nginx/.htpasswd;
        root /var/www/html;
        index index.html;
        try_files $uri $uri/ =404;
    }
}
```

### Reload
```
nginx -t
nginx -s reload
```

### 2. Tes dari Elwing
```
curl -I http://192.214.3.2/##
```

Output:
```
HTTP/1.1 301 Moved Permanently
Location: http://www.k06.com/
```

### Akses lewat sirion.k06.com
```
curl -I http://sirion.k06.com/
```

###  Hasil
```
HTTP/1.1 301 Moved Permanently
Location: http://www.k06.com/
```
### Akses lewat k06.com
```
curl -I http://www.k06.com/
```
Output:
```
HTTP/1.1 200 OK
```

## Soal 14
### Konfigurasi di Sirion (Reverse Proxy)
```
nano /etc/nginx/sites-available/www.k06.com
```

### Pastikan setiap blok proxy_pass (yaitu /app/ dan /static/) menyertakan header ini:
```
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Host $host;
```
### Jadi blok /app/ di Sirion seharusnya jadi seperti ini:
```
location /app/ {
    proxy_pass http://192.214.3.6/;  # Vingilot
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
}
```
### Reload
```
nginx -t
nginx -s reload
```
### Konfigurasi di Vingilot
```
nano /etc/nginx/nginx.conf
```
### Cari blok http { ... } di bagian atas, dan tambahkan / ubah baris ini di dalamnya:
```
http {
    log_format main '$http_x_real_ip - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    ...
}
```


### Pastikan Nginx tahu bahwa Sirion adalah proxy tepercaya
### supaya access_log mencatat IP klien asli (bukan IP Sirion)
set_real_ip_from 192.214.3.2;    # IP Sirion (reverse proxy)
real_ip_header X-Real-IP;
real_ip_recursive on;

#### KONFIG VINGILOT
```
server {
    listen 80;
    server_name app.k06.com;

    root /var/www/app.k06.com;
    index index.php;

    # -------------------------------
    # Halaman utama
    # -------------------------------
    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    # -------------------------------
    # Rewrite untuk /about tanpa .php
    # -------------------------------
    location /about {
        rewrite ^/about$ /about.php last;
    }

    # -------------------------------
    # PHP-FPM (jalankan file .php)
    # -------------------------------
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;

        # Tambahan agar IP asli juga diteruskan ke PHP
        fastcgi_param REMOTE_ADDR $remote_addr;
        fastcgi_param X-Real-IP $remote_addr;
    }

    # -------------------------------
    # Keamanan (blok file tersembunyi)
    # -------------------------------
    location ~ /\.ht {
        deny all;
    }

    # -------------------------------
    # Logging
    # -------------------------------
    access_log /var/log/nginx/app.k06.com.access.log;
    error_log /var/log/nginx/app.k06.com.error.log;
}
```

## Soal 15
### Instalasi ApacheBench di Elrond
```
apt update
```
```
apt install apache2-utils -y
```
### Jalankan Pengujian ke Endpoint /app/ dan /static/
### Uji ke /app/ (Vingilot via Sirion)
```
ab -n 500 -c 10 http://www.k06.com/app/
```
### Uji ke /static/ (Lindon via Sirion)
```
ab -n 500 -c 10 http://www.k06.com/static/
```
### Hasil yang Diharapkan
```
Server Software:        nginx
Server Hostname:        www.k06.com
Server Port:            80

Document Path:          /app/
Document Length:        120 bytes

Concurrency Level:      10
Time taken for tests:   1.543 seconds
Complete requests:      500
Failed requests:        0
Total transferred:      95000 bytes
Requests per second:    324.10 [#/sec] (mean)
Time per request:       30.86 [ms] (mean)
Transfer rate:          60.23 [Kbytes/sec] received

```

## Soal 16
### DI TIRION
```
nano /etc/bind/jarkom/k06.com
```

#### Ubah jadi
```
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
```
### DI VALMAR
```
ls -l /var/lib/bind/
```
```
dig @192.214.3.4 lindon.k06.com
```
### Output-nya harus sudah menunjuk ke 192.214.3.50.

### Cek dari klien (misal Elwing)
```
dig static.k06.com
```

## Soal 17
### buat file
nano /root/start-services.sh

### isi dengan
```
#!/bin/bash
echo "=== Memulai layanan inti K06 ==="

HOST=$(hostname)

case "$HOST" in

# ------------------------------------
# Tirion (DNS Master)
# ------------------------------------
tirion)
    echo "[Tirion] Menyalakan BIND9 (Master DNS)..."
    mkdir -p /var/cache/bind /etc/bind/jarkom
    pkill named 2>/dev/null
    named -c /etc/bind/named.conf -g &
    ;;

# ------------------------------------
# Valmar (DNS Slave)
# ------------------------------------
valmar)
    echo "[Valmar] Menyalakan BIND9 (Slave DNS)..."
    mkdir -p /var/lib/bind
    pkill named 2>/dev/null
    named -c /etc/bind/named.conf -g &
    ;;

# ------------------------------------
# Sirion (Reverse Proxy)
# ------------------------------------
sirion)
    echo "[Sirion] Menyalakan Nginx (Reverse Proxy)..."
    nginx -t && nginx
    ;;

# ------------------------------------
# Lindon (Web Statis)
# ------------------------------------
lindon)
    echo "[Lindon] Menyalakan Nginx (Web Statis)..."
    nginx -t && nginx
    ;;

# ------------------------------------
# Vingilot (Web Dinamis PHP-FPM)
# ------------------------------------
vingilot)
    echo "[Vingilot] Menyalakan PHP-FPM & Nginx..."
    mkdir -p /var/run/php
    php-fpm8.4 -D
    nginx -t && nginx
    ;;

*)
    echo "[!] Tidak ada konfigurasi autostart untuk hostname: $HOST"
    ;;
esac

echo "[OK] Semua layanan inti ($HOST) aktif."
```
### ubah permission 
```
chmod +x /root/start-services.sh
```
### Jalankan otomatis saat WSL startup
```
echo "bash /root/start-services.sh" >> /etc/bash.bashrc
```

### TUTUP SEMUA WSL

### start tirion

### Untuk tirion/valmar
```
ps aux | grep named
dig @localhost k06.com
```
### untuk sirion/lindon
```
ps aux | grep nginx
curl http://www.k06.com/
```
### untuk vingilot
```
ps aux | grep php
curl http://app.k06.com/
```
## Soal 18
### DI TIRION
nano /etc/bind/jarkom/k06.com

### Tambahkan berikut
```
; The Enemy Has Many Names 😈
melkor     IN  TXT     "Morgoth (Melkor)"
morgoth    IN  CNAME   melkor.k06.com.
```
```
### Naikkan serial pada file
@ IN SOA ns1.k06.com. root.k06.com. (
    2025101401 ; Serial naik setiap perubahan
    604800     ; Refresh
    86400      ; Retry
    2419200    ; Expire
    604800 )   ; Negative Cache TTL
;
```
### Validasi Konfig
```
named-checkzone k06.com /etc/bind/jarkom/k06.com
```
### kalau oke restart bind
```
pkill named
named -c /etc/bind/named.conf -g &
```
### sinkronasi di valmar
```
dig @192.214.3.4 melkor.k06.com TXT
```
### Verifikasi dari Klien (misal Elwing)
```
dig @192.214.3.3 melkor.k06.com TXT
```
### hasil yang benar:
```
;; ANSWER SECTION:
melkor.k06.com.   604800  IN  TXT  "Morgoth (Melkor)"
```
### cek alias cname
```
dig @192.214.3.3 morgoth.k06.com TXT
```
### Hasil yang benar:
```
;; ANSWER SECTION:
morgoth.k06.com.  604800  IN  CNAME  melkor.k06.com.
melkor.k06.com.   604800  IN  TXT    "Morgoth (Melkor)"
```
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
