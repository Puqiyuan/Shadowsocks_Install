#!/bin/bash
read -p "your ssh private key path that you create: " keyPath
ssh-add $keyPath

read -p "your IP got from Digital Ocean: " ip


file="./shadowsocks.json"
if [ -f "$file" ]; then
    rm ./shadowsocks.json
fi

/usr/bin/ssh-add /home/pqy7172/.ssh/cs3

scp puqiyuan@cs3.swfu.edu.cn:/home/staff/puqiyuan/shadowsocks.json ./shadowsocks.json

sed -i "s/.*server.*/\"server\":\"$ip\",/g" shadowsocks.json

scp ./shadowsocks.json  root@$ip:/etc/shadowsocks.json

ssh root@$ip 'bash -s' < ./freedom.sh

sudo rm ./shadowsocks.json
sudo rm ./shadowsocks.jsone
