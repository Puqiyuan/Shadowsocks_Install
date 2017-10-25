#!/bin/bash
read -p "your ssh private key path that you create: " keyPath
ssh-add $keyPath

read -p "your IP got from Digital Ocean: " ip


file="./shadowsocks.json"
if [ -f "$file" ]; then
    rm ./shadowsocks.json
fi

touch ./shadowsocks.json
echo { >> ./shadowsocks.json
       echo    \"server\":\"IP\", >> ./shadowsocks.json 
       echo     \"port_password\": >> ./shadowsocks.json
       echo     { >> ./shadowsocks.json
		  echo         \"8001\": \"password1\", >> ./shadowsocks.json

		  echo         \"8002\": \"password2\", >> ./shadowsocks.json

		  echo         \"8003\": \"password3\", >> ./shadowsocks.json

		  echo         \"8004\": \"password4\" >> ./shadowsocks.json
		  
		  
		  echo     }, >> ./shadowsocks.json
       echo    \"local_port\":1080, >> ./shadowsocks.json
       echo     \"timeout\":600, >> ./shadowsocks.json
       echo     \"method\":\"chacha20\" >> ./shadowsocks.json
       echo } >> ./shadowsocks.json

sed -i "s/IP/$ip/g" ./shadowsocks.json

scp ./shadowsocks.json  root@$ip:/etc/shadowsocks.json



ssh root@$ip 'bash -s' < ./freedom.sh
