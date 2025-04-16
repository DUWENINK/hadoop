# Hadoop Ecosystem with Docker

这是一个使用Docker Compose部署的Hadoop生态系统，包含以下组件：
- Hadoop HDFS (NameNode, DataNode)
- YARN (ResourceManager, NodeManager)
- Spark (Master, Worker)
- Hive (Metastore, HiveServer2)
- MySQL (用于Hive元数据存储)

## 环境要求

- Docker 20.10.0+
- Docker Compose 2.0.0+
- 至少8GB内存
- 至少20GB磁盘空间

## 目录结构

```
.
├── config/              # Hadoop配置文件
├── hadoop_data/        # HDFS数据存储
│   ├── namenode/       # NameNode数据
│   └── datanode/       # DataNode数据
├── hive-config/        # Hive配置文件
├── hive-data/          # Hive数据存储
├── mysql_data/         # MySQL数据存储
├── spark_data/         # Spark数据存储
│   ├── logs/          # Spark日志
│   └── work/          # Spark工作目录
├── docker-compose.yml  # Docker Compose配置
├── init-hadoop.sh      # Hadoop初始化脚本
├── init-hive.sh        # Hive初始化脚本
└── cleanup.sh          # 清理脚本
```

## 快速开始

1. 克隆仓库：
```bash
git clone <repository-url>
cd hadoop
```

2. 启动服务：
```bash
docker-compose up -d
```

3. 等待所有服务启动完成（约1-2分钟）

4. 访问Web界面：
- HDFS NameNode: http://localhost:9870
- YARN ResourceManager: http://localhost:8088
- Spark Master: http://localhost:8080
- HiveServer2 WebUI: http://localhost:10002

## 服务说明

### Hadoop HDFS
- NameNode: 管理HDFS文件系统的命名空间
- DataNode: 存储实际数据块
- 端口：
  - NameNode WebUI: 9870
  - HDFS: 9000

### YARN
- ResourceManager: 管理集群资源
- NodeManager: 管理单个节点资源
- 端口：
  - ResourceManager WebUI: 8088

### Spark
- Master: 管理Spark集群
- Worker: 执行Spark任务
- 端口：
  - Master WebUI: 8080
  - Worker WebUI: 8081
  - Spark Master: 7077

### Hive
- Metastore: 存储元数据
- HiveServer2: 提供JDBC/ODBC接口
- 端口：
  - Metastore: 9083
  - HiveServer2: 10000
  - HiveServer2 WebUI: 10002

### MySQL
- 用于存储Hive元数据
- 端口：3306
- 默认凭据：
  - 用户名：root
  - 密码：root
  - 数据库：hive

## 使用示例

### 1. 使用HDFS
```bash
# 进入NameNode容器
docker exec -it namenode bash

# 创建目录
hdfs dfs -mkdir /test

# 上传文件
hdfs dfs -put localfile /test/

# 查看文件
hdfs dfs -ls /test
```

### 2. 使用Hive
```bash
# 进入HiveServer2容器
docker exec -it hive-server bash

# 启动Hive CLI
/opt/hive/bin/hive

# 创建表
CREATE TABLE test (id INT, name STRING);

# 插入数据
INSERT INTO test VALUES (1, 'test');

# 查询数据
SELECT * FROM test;
```

### 3. 使用Spark
```bash
# 进入Spark Master容器
docker exec -it spark-master bash

# 启动Spark Shell
/opt/spark/bin/spark-shell

# 或者提交Spark作业
/opt/spark/bin/spark-submit --master spark://spark-master:7077 your_app.py
```

## 维护

### 清理数据
```bash
# 停止所有容器并删除数据
./cleanup.sh
```

### 重启服务
```bash
# 重启所有服务
docker-compose restart

# 重启特定服务
docker-compose restart hive-metastore hive-server
```

### 查看日志
```bash
# 查看所有服务日志
docker-compose logs -f

# 查看特定服务日志
docker-compose logs -f hive-metastore
```

## 故障排除

1. 如果Hive服务无法启动：
   - 检查MySQL服务是否正常运行
   - 检查HDFS目录权限
   - 查看Hive Metastore日志

2. 如果Spark作业失败：
   - 检查YARN资源管理器状态
   - 检查Spark Worker日志
   - 确保HDFS正常运行

3. 如果HDFS出现问题：
   - 检查NameNode和DataNode日志
   - 确保磁盘空间充足
   - 检查网络连接

## 注意事项

1. 生产环境部署时，请修改默认密码
2. 根据实际需求调整内存限制
3. 定期备份重要数据
4. 监控系统资源使用情况

## 许可证

MIT License 