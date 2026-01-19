#!/bin/bash

wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.2/hadoop-3.4.2.tar.gz ./
tar -zxf hadoop-3.4.2.tar.gz -C ./libs/hadoop --strip-components 1
wget http://ftp.ru.debian.org/debian/pool/main/j/java-common/default-jdk_1.21-76_amd64.deb ./libs