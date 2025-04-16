#!/bin/bash

# 等待namenode启动
echo "Waiting for namenode..."
while ! nc -z namenode 9000; do   
  sleep 1
done

# 等待MySQL启动
echo "Waiting for MySQL..."
while ! nc -z mysql 3306; do
  sleep 1
done

# 下载MySQL驱动
echo "Downloading MySQL driver..."
wget -P /opt/hive/lib https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar

# 清理旧的Derby数据库
echo "Cleaning up old Derby database..."
rm -rf /opt/hive/metastore_db

# 创建Hive所需的HDFS目录
echo "Creating HDFS directories for Hive..."
hdfs dfs -mkdir -p /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse

echo "Hive directories initialized successfully"