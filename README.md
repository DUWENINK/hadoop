# Hadoop 集群部署

基于 Docker Compose 的 Hadoop 集群部署方案，包含以下组件：

- Hadoop HDFS (NameNode + DataNode)
- Hadoop YARN (ResourceManager + NodeManager)
- Apache Spark (Master + Worker)
- Apache Hive (Metastore + HiveServer2)

## 服务访问地址

### Hadoop 服务
- HDFS NameNode Web UI: http://localhost:9870
- HDFS DataNode Web UI: http://localhost:9864
- YARN ResourceManager Web UI: http://localhost:8088
- YARN NodeManager Web UI: http://localhost:8042

### Spark 服务
- Spark Master Web UI: http://localhost:8080
- Spark Worker Web UI: http://localhost:8081
- Spark Master URL: spark://localhost:7077

### Hive 服务
- HiveServer2 JDBC URL: jdbc:hive2://localhost:10000
- HiveServer2 Web UI: http://localhost:10002
- Hive Metastore Thrift URL: thrift://localhost:9083

## 快速开始

1. 克隆仓库：
```bash
git clone [repository-url]
cd hadoop
```

2. 启动服务：
```bash
docker-compose up -d
```

3. 检查服务状态：
```bash
docker-compose ps
```

4. 查看服务日志：
```bash
docker-compose logs -f [service-name]
```

## 服务说明

### Hadoop HDFS
- NameNode: HDFS 的主节点，管理文件系统的命名空间
- DataNode: HDFS 的数据节点，存储实际数据

### Hadoop YARN
- ResourceManager: 集群资源管理器
- NodeManager: 节点资源管理器

### Apache Spark
- Master: Spark 主节点，负责资源调度
- Worker: Spark 工作节点，执行实际任务

### Apache Hive
- Metastore: Hive 元数据存储服务
- HiveServer2: Hive 查询服务

## 数据持久化

所有数据都存储在本地目录中：
- Hadoop 数据: `./hadoop_data/`
- Spark 数据: `./spark_data/`
- Hive 数据: `./hive-data/`

## 配置说明

- Hadoop 配置: `./config/`
- Hive 配置: `./hive-config/`

## 常用命令

### HDFS 操作
```bash
# 查看 HDFS 文件系统
docker exec -it namenode hdfs dfs -ls /

# 创建目录
docker exec -it namenode hdfs dfs -mkdir /user

# 上传文件
docker exec -it namenode hdfs dfs -put localfile /user/
```

### Hive 操作
```bash
# 使用 Beeline 连接 Hive
docker exec -it hive-server beeline -u jdbc:hive2://localhost:10000

# 使用 Hive CLI
docker exec -it hive-server hive
```

### Spark 操作
```bash
# 提交 Spark 作业
docker exec -it spark-master spark-submit --master spark://spark-master:7077 your-app.py
```

## 注意事项

1. 首次启动时，NameNode 会自动格式化
2. 确保本地目录有足够的磁盘空间
3. 默认使用 Derby 作为 Hive 的元数据库
4. 所有服务都以 root 用户运行

## 故障排除

1. 检查服务日志：
```bash
docker-compose logs -f [service-name]
```

2. 重启单个服务：
```bash
docker-compose restart [service-name]
```

3. 完全重新启动：
```bash
docker-compose down
docker-compose up -d
```

## 许可证

[许可证类型] 