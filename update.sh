#!/bin/bash

oldPort=`cat ./port`
newPort=$(($oldPort+1))
echo $newPort > ./port

password=`tail -1 Info.csv | awk -F, '{print $2;}'`
email=`tail -1 Info.csv | awk -F, '{print $3;}'`

sed -ie '4a\ '\"$oldPort\":\"$password\",'' shadowsocks.json

mv /etc/shadowsocks.json /etc/shadowsocks_bak.json

cp ./shadowsocks.json /etc/shadowsocks.json

/usr/bin/python /usr/local/bin/ssserver -c /etc/shadowsocks.json -d restart

echo "Your port is $oldPort, and password is $password, encryption method is chacha20, please check https://github.com/Puqiyuan/IP_Server/blob/master/list or https://share.weiyun.com/eba6100a8ce08f53e474088325edcf70 for available IP. As for how to bypass please check http://167.99.108.111:8080/Fq/register. If you have never bypassed or don't know how to configure, please consult QQ 1306210956 before you send an email to the Google group, we recommend that you first contact our customer service staff-lym(QQ 1306210956), she is also a member of our YCH volunteer team. This email is automatically sent out, please DO NOT reply this email address, if you have any problem, suggests, complaint please send email to polarisych@googlegroups.com, thanks. YCH Information Team welcome to hear from you." | mail -s "Password and Port" $email
