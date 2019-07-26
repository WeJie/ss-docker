FROM ubuntu:16.04

RUN apt-get update && apt-get install python-pip wget -y && pip install shadowsocks 

ADD shadowsocks.json /etc/

WORKDIR /home/ubuntu

ADD ss-ban.log /home/ubuntu/log
ADD ss.sh /home/ubuntu/ss.sh
RUN chmod +x ss.sh

RUN wget https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/utils/autoban.py
RUN echo 'sudo ssserver -c /etc/shadowsocks.json -d start\n\
					nohup tail -F /var/log/shadowsocks.log | python /home/ubunntu/autoban.py >log 2>log &' > /etc/rc.local
