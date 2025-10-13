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


---

## Soal 3

Kabar dari Barat menyapa Timur. Pastikan kelima klien dapat saling berkomunikasi lintas jalur (routing internal via Eonwe berfungsi), lalu pastikan setiap host non-router menambahkan resolver 192.168.122.1 saat interfacenya aktif agar akses paket dari internet tersedia sejak awal.

### Penjelasan 


---

## Soal 4

Para penjaga nama naik ke menara, di Tirion (ns1/master) bangun zona <xxxx>.com sebagai authoritative dengan SOA yang menunjuk ke ns1.<xxxx>.com dan catatan NS untuk ns1.<xxxx>.com dan ns2.<xxxx>.com. Buat A record untuk ns1.<xxxx>.com dan ns2.<xxxx>.com yang mengarah ke alamat Tirion dan Valmar sesuai glosarium, serta A record apex <xxxx>.com yang mengarah ke alamat Sirion (front door), aktifkan notify dan allow-transfer ke Valmar, set forwarders ke 192.168.122.1. Di Valmar (ns2/slave) tarik zona <xxxx>.com dari Tirion dan pastikan menjawab authoritative. pada seluruh host non-router ubah urutan resolver menjadi IP dari ns1.<xxxx>.com → ns2.<xxxx>.com → 192.168.122.1. Verifikasi query ke apex dan hostname layanan dalam zona dijawab melalui ns1/ns2.

### Penjelasan 


---

## Soal 5

“Nama memberi arah,” kata Eonwe. Namai semua tokoh (hostname) sesuai glosarium, eonwe, earendil, elwing, cirdan, elrond, maglor, sirion, tirion, valmar, lindon, vingilot, dan verifikasi bahwa setiap host mengenali dan menggunakan hostname tersebut secara system-wide. Buat setiap domain untuk masing masing node sesuai dengan namanya (contoh: eru.<xxxx>.com) dan assign IP masing-masing juga. Lakukan pengecualian untuk node yang bertanggung jawab atas ns1 dan ns2

### Penjelasan 


---

## Soal 6

Lonceng Valmar berdentang mengikuti irama Tirion. Pastikan zone transfer berjalan, Pastikan Valmar (ns2) telah menerima salinan zona terbaru dari Tirion (ns1). Nilai serial SOA di keduanya harus sama

### Penjelasan 


---

## Soal 7

Peta kota dan pelabuhan dilukis. Sirion sebagai gerbang, Lindon sebagai web statis, Vingilot sebagai web dinamis. Tambahkan pada zona <xxxx>.com A record untuk sirion.<xxxx>.com (IP Sirion), lindon.<xxxx>.com (IP Lindon), dan vingilot.<xxxx>.com (IP Vingilot). Tetapkan CNAME :
www.<xxxx>.com → sirion.<xxxx>.com, 
static.<xxxx>.com → lindon.<xxxx>.com, dan 
app.<xxxx>.com → vingilot.<xxxx>.com. 
Verifikasi dari dua klien berbeda bahwa seluruh hostname tersebut ter-resolve ke tujuan yang benar dan konsisten.

### Penjelasan 


---

## Soal 8

Setiap jejak harus bisa diikuti. Di Tirion (ns1) deklarasikan satu reverse zone untuk segmen DMZ tempat Sirion, Lindon, Vingilot berada. Di Valmar (ns2) tarik reverse zone tersebut sebagai slave, isi PTR untuk ketiga hostname itu agar pencarian balik IP address mengembalikan hostname yang benar, lalu pastikan query reverse untuk alamat Sirion, Lindon, Vingilot dijawab authoritative.

### Penjelasan 


---

## Soal 9

Lampion Lindon dinyalakan. Jalankan web statis pada hostname static.<xxxx>.com dan buka folder arsip /annals/ dengan autoindex (directory listing) sehingga isinya dapat ditelusuri. Akses harus dilakukan melalui hostname, bukan IP.

### Penjelasan 


---

## Soal 10

Vingilot mengisahkan cerita dinamis. Jalankan web dinamis (PHP-FPM) pada hostname app.<xxxx>.com dengan beranda dan halaman about, serta terapkan rewrite sehingga /about berfungsi tanpa akhiran .php. Akses harus dilakukan melalui hostname.

### Penjelasan 


---
