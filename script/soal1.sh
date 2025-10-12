# Setting config network 

# NODE EONWE
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

# NODE EARENDIL
auto eth0
iface eth0 inet static
    address 192.214.1.2
    netmask 255.255.255.0
    gateway 192.214.1.1

# NODE ELWING
auto eth0
iface eth0 inet static
    address 192.214.1.3
    netmask 255.255.255.0
    gateway 192.214.1.1

# NODE CIRDAN
auto eth0
iface eth0 inet static
    address 192.214.2.2
    netmask 255.255.255.0
    gateway 192.214.2.1

# NODE ELROND
auto eth0
iface eth0 inet static
    address 192.214.2.3
    netmask 255.255.255.0
    gateway 192.214.2.1

# NODE MAGLOR
auto eth0
iface eth0 inet static
    address 192.214.2.4
    netmask 255.255.255.0
    gateway 192.214.2.1

# NODE SIRION
auto eth0
iface eth0 inet static
    address 192.214.3.2
    netmask 255.255.255.0
    gateway 192.214.3.1
   
# NODE TIRION
auto eth0
iface eth0 inet static
    address 192.214.3.3
    netmask 255.255.255.0
    gateway 192.214.3.1

# NODE VALMAR
auto eth0
iface eth0 inet static
    address 192.214.3.4
    netmask 255.255.255.0
    gateway 192.214.3.1

# NODE LINDON
auto eth0
iface eth0 inet static
    address 192.214.3.5
    netmask 255.255.255.0
    gateway 192.214.3.1

# NODE VINGILOT
auto eth0
iface eth0 inet static
    address 192.214.3.6
    netmask 255.255.255.0
    gateway 192.214.3.1