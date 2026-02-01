# #!/bin/bash

sudo iptables -I INPUT -p tcp --match multiport --dports 9866,9864,9867 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8020 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 9870 -j ACCEPT
sudo apt install -y iptables-persistent
sudo netfilter-persistent save

wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.2/hadoop-3.4.2.tar.gz
mkdir ./libs
mkdir ./libs/hadoop
tar -zxf hadoop-3.4.2.tar.gz -C ./libs/hadoop --strip-components 1
mkdir keys
ssh-keygen -t rsa -b 4096 -f keys/id_rsa_hadoop -N "" -C "hadoop@docker"
sudo chmod 644 keys/id_rsa_hadoop

cp ./configs/core-site.xml ./libs/hadoop/etc/hadoop/core-site.xml
cp ./configs/hdfs-site.xml ./libs/hadoop/etc/hadoop/hdfs-site.xml
cp ./configs/mapred-site.xml ./libs/hadoop/etc/hadoop/mapred-site.xml
cp ./configs/yarn-site.xml ./libs/hadoop/etc/hadoop/yarn-site.xml 