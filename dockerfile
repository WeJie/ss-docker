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

ADD ss-ban.log /home/ubuntu/log
ADD ss.sh /home/ubuntu/ss.sh
RUN chmod +x ss.sh

RUN wget https://raw.githubusercontent.com/shadowsocks/shadowsocks/master/utils/autoban.py
RUN echo 'sudo ssserver -c /etc/shadowsocks.json -d start\n\
          python /home/ubuntu/autoban.py < /var/log/shadowsocks.log\n\
					nohup tail -F /var/log/shadowsocks.log | python /home/ubunntu/autoban.py >log 2>log &' > /etc/rc.local

EXPOSE 701

