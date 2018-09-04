#!/bin/bash
read -p "your ssh private key path that you create: " keyPath
ssh-add $keyPath

read -p "your IP got from Digital Ocean: " ip


file="./shadowsocks.json"
if [ -f "$file" ]; then
    rm ./shadowsocks.json
fi

/usr/bin/ssh-add /home/pqy7172/.ssh/cs3

scp puqiyuan@cs3.swfu.edu.cn:/home/staff/puqiyuan/shadowsocks.json ./.shadowsocks.json

scp puqiyuan@cs3.swfu.edu.cn:/home/staff/puqiyuan/Info.csv ./.Info.csv

scp puqiyuan@cs3.swfu.edu.cn:/home/staff/puqiyuan/port ./.port

sed -i "s/.*server.*/\"server\":\"$ip\",/g" shadowsocks.json

scp ~/.shadowsocks.json  root@$ip:/etc/shadowsocks.json

scp ~/.shadowsocks.json  root@$ip:/root/shadsocks.json

scp ~/.Info.csv  root@$ip:/root/Info.csv

scp ~/.port  root@$ip:/root/port

scp ./update.sh root@$ip:/root/update.sh

ssh root@$ip: 'git clone https://github.com/teddysun/shadowsocks_install.git'

ssh root@$ip


