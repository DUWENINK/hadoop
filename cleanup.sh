#!/bin/bash

# 清理 HDFS 垃圾箱
docker exec namenode hdfs dfs -expunge

# 清理旧的日志文件（保留最近7天的）
find ./spark_data/logs -type f -mtime +7 -delete

# 清理 HDFS 临时文件
docker exec namenode hdfs dfs -rm -r -skipTrash /tmp/*
docker exec namenode hdfs dfs -rm -r -skipTrash /user/*/.Trash/*

# 清理 Spark 工作目录
find ./spark_data/work -type f -mtime +1 -delete

# 清理 Docker 日志
docker exec namenode truncate -s 0 /opt/hadoop/logs/*
docker exec datanode1 truncate -s 0 /opt/hadoop/logs/*
docker exec resourcemanager truncate -s 0 /opt/hadoop/logs/*
docker exec nodemanager truncate -s 0 /opt/hadoop/logs/*
docker exec spark-master truncate -s 0 /opt/spark/logs/*
docker exec spark-worker truncate -s 0 /opt/spark/logs/*

# 清理 Docker 系统
docker system prune -f 