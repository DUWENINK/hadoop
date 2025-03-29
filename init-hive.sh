#!/bin/bash

# 等待namenode启动
echo "Waiting for namenode..."
while ! nc -z namenode 9000; do   
  sleep 1
done

# 创建Hive所需的HDFS目录
echo "Creating HDFS directories for Hive..."
hdfs dfs -mkdir -p /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse

echo "Hive directories initialized successfully"