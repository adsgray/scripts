
#https://www.comparitech.com/blog/vpn-privacy/how-to-make-your-own-free-vpn-using-amazon-web-services/



install () {
  sudo yum install openvpn
  sudo yum install easy-rsa -y --enablerepo=epel
}


iptables () {
    sudo modprobe iptable_nat
    echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
    sudo iptables -t nat -A POSTROUTING -s 10.4.0.1/2 -o eth0 -j MASQUERADE
    sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
}


easyrsa () {
    sudo mkdir /etc/openvpn/easy-rsa
    cd /etc/openvpn/easy-rsa
    sudo cp -Rv /usr/share/easy-rsa/3.0.8/* .
}

easyrsa2 () {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa init-pki
    sudo ./easyrsa build-ca
}

easyrsa3 () {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa gen-dh
}

easyrsa4() {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa gen-req server nopass
}

easyrsa5() {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa sign-req server server
}

easyrsa6() {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa gen-req client nopass
}

easyrsa7() {
    cd /etc/openvpn/easy-rsa
    sudo ./easyrsa sign-req client client
}

openvpn_pfs() {
    cd /etc/openvpn
    sudo openvpn --genkey --secret pfs.key
}

openvpn_cfg() {
    cd /etc/openvpn
    sudo bash -c "cat > server.conf" <<EOF
port 1194
proto udp
dev tun
ca /etc/openvpn/easy-rsa/pki/ca.crt
cert /etc/openvpn/easy-rsa/pki/issued/server.crt
key /etc/openvpn/easy-rsa/pki/private/server.key
dh /etc/openvpn/easy-rsa/pki/dh.pem
cipher AES-256-CBC
auth SHA512
server 10.8.0.0 255.255.255.0
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
ifconfig-pool-persist ipp.txt
keepalive 10 120
comp-lzo
persist-key
persist-tun
status openvpn-status.log
log-append openvpn.log
verb 3
tls-server
tls-auth /etc/openvpn/pfs.key
EOF

   sudo bash -c "cat > server.sh" <<EOF
#!/bin/sh
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -s 10.4.0.1/2 -o eth0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
EOF
    sudo chmod +x server.sh
}

openvpn_copykeys() {
    cd
    mkdir keys
    dest=$(pwd)/keys
    echo $dest
    cd /etc/openvpn

    sudo cp pfs.key $dest
    sudo cp /etc/openvpn/easy-rsa/pki/dh.pem $dest
    sudo cp /etc/openvpn/easy-rsa/pki/ca.crt $dest
    sudo cp /etc/openvpn/easy-rsa/pki/private/ca.key $dest
    sudo cp /etc/openvpn/easy-rsa/pki/private/client.key $dest
    sudo cp /etc/openvpn/easy-rsa/pki/issued/client.crt $dest
    cd
    sudo chown ec2-user keys/*
}

openvpn_removekey() {
    sudo rm /etc/openvpn/easy-rsa/pki/private/ca.key
    sudo rm /etc/openvpn/keys/ca.key
}

#easyrsa7
#openvpn_pfs
#openvpn_cfg
#openvpn_copykeys

openvpn_removekey

#sudo service openvpn start
#sudo chkconfig openvpn on


