#!/bin/bash

docker exec -it -u hadoop hadoop1_master bash -cl "mkdir -p /home/hadoop/hadoopdata/hdfs/namenode"
docker exec -it -u hadoop hadoop1_master bash -cl "hdfs namenode -format && start-dfs.sh && hadoop fs -chown dr.who / && start-yarn.sh"
