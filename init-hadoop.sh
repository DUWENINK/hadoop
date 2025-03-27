#!/bin/bash

# Create Hadoop directories
mkdir -p /root/hadoop/hadoop_data/namenode
mkdir -p /root/hadoop/hadoop_data/datanode

# Create Spark directories
mkdir -p /root/hadoop/spark_data/logs
mkdir -p /root/hadoop/spark_data/work

# Set permissions
chmod -R 777 /root/hadoop/hadoop_data
chmod -R 777 /root/hadoop/spark_data

echo "Hadoop and Spark directories initialized successfully"