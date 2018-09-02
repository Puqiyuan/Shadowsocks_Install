apt-get update
apt-get install python-pip -y
export LC_ALL=C
pip install shadowsocks
apt-get install python-m2crypto -y
apt-get install build-essential -y
apt-get install mosh -y

file="/root/libsodium-1.0.10.tar.gz"
if [ -f "$file" ]; then
    rm /root/libsodium-1.0.10.tar.gz
    rm /root/libsodium-1.0.10
fi

wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz 
tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
./configure && make && make install
ldconfig

file=/etc/rc.local
if [ -f "$file" ];
then
    cp /etc/rc.local /etc/rc.local.bak
    rm /etc/rc.local
    touch /etc/rc.local
    echo /usr/bin/python /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start >> $file
    echo exit 0 >> $file
    
    
else
    touch /etc/rc.local
    echo /usr/bin/python /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start >> $file
    echo exit 0 >> $file
fi

sed -ie "\$a* soft nofile 51200" /etc/security/limits.conf
sed -ie "\$a* hard nofile 51200" /etc/security/limits.conf

ssserver -c /etc/shadowsocks.json -d stop

ulimit -n 51200


file=/root/sysctl.conf
if [ -f "$file" ]; then
    rm /root/sysctl.conf
fi

touch /root/sysctl.conf

ed /root/sysctl.conf
a
fs.file-max = 51200

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_congestion_control = cubic
.
w
q

cat /root/sysctl.conf >> /etc/sysctl.conf

sysctl -p

ssserver -c /etc/shadowsocks.json -d restart

locale-gen zh_CN.UTF-8

echo
echo
echo
echo =======================Attention=====================
echo Maybe ERROR'('s')' emerging, but everthing is OK.
echo Now, please feel free to test your new Shadowsocks.
echo By pass the GFW, you can reach every corner of this world.
echo This is your completely justified freedom, have fun!:')'
echo ==========================End=========================
echo
echo
echo
