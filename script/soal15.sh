## Instalasi ApacheBench di Elrond
apt update
apt install apache2-utils -y

## Jalankan Pengujian ke Endpoint /app/ dan /static/
## Uji ke /app/ (Vingilot via Sirion)
ab -n 500 -c 10 http://www.k06.com/app/

## Uji ke /static/ (Lindon via Sirion)
ab -n 500 -c 10 http://www.k06.com/static/
## Hasil yang Diharapkan
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
