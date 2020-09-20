#!/bin/bash

start_system() {
    cd /
    /etc/init.d/ssh start

    echo "export HDFS_DATANODE_USER=root" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
    echo "export HDFS_SECURE_DN_USER=hdfs" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh #HADOOP_SECURE_DN_USER
    echo "export HDFS_NAMENODE_USER=root" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
    echo "export HDFS_SECONDARYNAMENODE_USER=root" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
    echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh 
    echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"' >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh 
    echo "export JAVA_HOME=${JAVA_HOME}" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh 

    sudo ${HADOOP_HOME}/bin/hdfs namenode -format -y
    sudo ${HADOOP_HOME}/sbin/start-dfs.sh
    sudo ${SPARK_HOME}/sbin/start-all.sh

    sudo jps
}


echo "STARTING SYSTEM"
start_system