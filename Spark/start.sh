#!/bin/bash

start_system() {
    cd /

    ${HADOOP_HOME}/bin/hdfs namenode -format -y
    ${HADOOP_HOME}/sbin/start-dfs.sh
    ${SPARK_HOME}/sbin/start-all.sh
    jps
}


echo "STARTING SYSTEM"
start_system