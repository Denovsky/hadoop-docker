#!/bin/bash

sudo iptables -I INPUT -p tcp --match multiport --dports 9866,9864,9867 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8020 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 9870 -j ACCEPT
sudo apt install -y iptables-persistent
sudo netfilter-persistent save

wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.2/hadoop-3.4.2.tar.gz
mkdir ./libs/hadoop
tar -zxf hadoop-3.4.2.tar.gz -C ./libs/hadoop --strip-components 1
wget http://ftp.ru.debian.org/debian/pool/main/j/java-common/default-jdk_1.21-76_amd64.deb -P ./libs
mkdir keys
ssh-keygen -t rsa -b 4096 -f keys/id_rsa_hadoop -N "" -C "hadoop@docker"