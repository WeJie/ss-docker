#! /bin/bash

ssserver -c /etc/shadowsocks.json -d start
/home/ubuntu/autoban.py < /var/log/shadowsocks.log
nohup tail -F /var/log/shadowsocks.log | python /home/ubunntu/autoban.py >log 2>log &

