FROM ubuntu:16.04

RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse\n\
    deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse\n\
    deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
    deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
    deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
    deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse\n\
    deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse\n\
    deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
    deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
    deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
    ' > /etc/apt/sources.list

RUN apt-get update
RUN apt-get install python-pip wget -y
RUN pip install --upgrade pip
RUN pip install shadowsocks 

ADD shadowsocks.json /etc/

WORKDIR /home/ubuntu
RUN cd /home/ubuntu

ADD ss-ban.log /home/ubuntu

RUN wget https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/utils/autoban.py
RUN echo 'sudo ssserver -c /etc/shadowsocks.json -d start\n\
          /root/autoban.py < /var/log/shadowsocks.log\n\
					nohup tail -F /var/log/shadowsocks.log | python /root/autoban.py >log 2>log &' > /etc/rc.local

EXPOSE 701 10087

