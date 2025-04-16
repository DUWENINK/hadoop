#!/bin/bash

# 等待 MySQL 启动
while ! nc -z mysql 3306; do
  echo "Waiting for MySQL to start..."
  sleep 1
done

# 初始化 Hive Schema
/opt/hive/bin/schematool -dbType mysql -initSchema

# 启动 Hive 服务
if [ "$1" = "metastore" ]; then
  exec /opt/hive/bin/hive --service metastore
elif [ "$1" = "hiveserver2" ]; then
  exec /opt/hive/bin/hive --service hiveserver2
else
  echo "Invalid service name. Use 'metastore' or 'hiveserver2'"
  exit 1
fi 