FROM debian:stable-slim

USER root

COPY ./libs/hadoop /usr/local/hadoop
COPY ./libs/default-jdk_1.21-76_amd64.deb /

RUN apt update && apt upgrade && \
    apt install -y /default-jdk_1.21-76_amd64.deb && \
    sed -i.bak 's|# export JAVA_HOME=|export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64|' /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    useradd hadoop -m && \
    echo "hadoop:hadoop" | sudo chpasswd && \
    chown -R hadoop:hadoop /usr/local/hadoop

COPY ./libs/etc/profile.d/hadoop.sh /etc/profile.d/hadoop.sh

EXPOSE 22
EXPOSE 9870
EXPOSE 8020
EXPOSE 9866
EXPOSE 9864
EXPOSE 9867

CMD sleep infinity