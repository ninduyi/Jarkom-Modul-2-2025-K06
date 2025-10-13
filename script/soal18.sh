## DI TIRION
nano /etc/bind/jarkom/k06.com

## Tambahkan berikut
; The Enemy Has Many Names 😈
melkor     IN  TXT     "Morgoth (Melkor)"
morgoth    IN  CNAME   melkor.k06.com.

## Naikkan serial pada file
@ IN SOA ns1.k06.com. root.k06.com. (
    2025101401 ; Serial naik setiap perubahan
    604800     ; Refresh
    86400      ; Retry
    2419200    ; Expire
    604800 )   ; Negative Cache TTL
;

## Validasi Konfig
named-checkzone k06.com /etc/bind/jarkom/k06.com

## kalau oke restart bind
pkill named
named -c /etc/bind/named.conf -g &

## sinkronasi di valmar
dig @192.214.3.4 melkor.k06.com TXT

## Verifikasi dari Klien (misal Elwing)
dig @192.214.3.3 melkor.k06.com TXT
## hasil yang benar:
;; ANSWER SECTION:
melkor.k06.com.   604800  IN  TXT  "Morgoth (Melkor)"

## cek alias cname
dig @192.214.3.3 morgoth.k06.com TXT

## Hasil yang benar:
;; ANSWER SECTION:
morgoth.k06.com.  604800  IN  CNAME  melkor.k06.com.
melkor.k06.com.   604800  IN  TXT    "Morgoth (Melkor)"
