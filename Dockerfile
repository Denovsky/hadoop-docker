FROM debian:stable-slim

USER root

COPY ./libs/hadoop /usr/local/hadoop

RUN apt update && apt upgrade -y && \
    apt install -y default-jdk openssh-client openssh-server sshpass

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh
    
RUN useradd -m -s /bin/bash hadoop 2>/dev/null || true && \
    echo "hadoop:hadoop" | chpasswd

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_HOME=/usr/local/hadoop' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_INSTALL=$HADOOP_HOME' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_YARN_HOME=$HADOOP_HOME' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >> /home/hadoop/.bashrc && \
    echo 'export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin' >> /home/hadoop/.bashrc && \
    echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"' >> /home/hadoop/.bashrc

COPY ./libs/etc/profile.d/hadoop.sh /etc/profile.d/hadoop.sh

RUN mkdir -p /home/hadoop/hadoopdata/hdfs/datanode

RUN mkdir -p /home/hadoop/.ssh && \
    chmod 700 /home/hadoop/.ssh && \
    chown -R hadoop:hadoop /home/hadoop/.ssh && \
    mkdir -p /var/run/sshd

COPY ./keys/id_rsa_hadoop /home/hadoop/.ssh/id_rsa
COPY ./keys/id_rsa_hadoop.pub /home/hadoop/.ssh/id_rsa.pub
COPY ./keys/id_rsa_hadoop.pub /home/hadoop/.ssh/authorized_keys

RUN chown hadoop:hadoop /home/hadoop/.ssh/id_rsa && \
    chmod 600 /home/hadoop/.ssh/id_rsa && \
    chown hadoop:hadoop /home/hadoop/.ssh/id_rsa.pub && \
    chmod 644 /home/hadoop/.ssh/id_rsa.pub && \
    chown hadoop:hadoop /home/hadoop/.ssh/authorized_keys && \
    chmod 600 /home/hadoop/.ssh/authorized_keys

RUN echo "IdentityFile ~/.ssh/id_rsa" >> /home/hadoop/.ssh/config && \
    echo "StrictHostKeyChecking no" >> /home/hadoop/.ssh/config && \
    echo "UserKnownHostsFile /dev/null" >> /home/hadoop/.ssh/config && \
    chown hadoop:hadoop /home/hadoop/.ssh/config && \
    chmod 600 /home/hadoop/.ssh/config

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config

RUN echo "hadoop2" >> /usr/local/hadoop/etc/hadoop/workers && \
    echo "hadoop3" >> /usr/local/hadoop/etc/hadoop/workers

RUN chown -R hadoop:hadoop /usr/local/hadoop
RUN chown -R hadoop:hadoop /home/hadoop/

EXPOSE 22
EXPOSE 9870
EXPOSE 8020
EXPOSE 8088
EXPOSE 19888

CMD ["/usr/sbin/sshd", "-D"]