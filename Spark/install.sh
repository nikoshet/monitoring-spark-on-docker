#!/bin/bash

# Environment Variables
# JAVA
echo 'JAVA_HOME = /usr/lib/jvm/java-8-openjdk-amd64/'
# HADOOP
echo 'HADOOP_VERSION = "3.2"'
echo 'HADOOP_HOME = /usr/hadoop-${HADOOP_VERSION}'
echo 'HADOOP_CONF_DIR = ${HADOOP_HOME}/etc/hadoop'
# SPARK
echo 'SPARK_VERSION = "3.0.1"'
echo 'SPARK_HOME = /usr/spark-${SPARK_VERSION}'
echo 'SPARK_PACKAGE = spark-${SPARK_VERSION}-bin${HADOOP_VERSION}'


# Functions For Installation
install_python() {
    apt-get install -y python3 python3-setuptools
    ln -s /usr/bin/python3 /usr/bin/python 
    python --version
}

install_java() {
    apt-get install -y openjdk-8-jdk

    echo 'export JAVA_HOME=${JAVA_HOME}' >> ~/.bashrc
    echo 'export PATH=${JAVA_HOME}/jre/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
    java -version
}


install_hadoop() {
	wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz
    rm -rf ${HADOOP_HOME}/share/doc 
    chown -R root:root ${HADOOP_HOME}

    echo 'export HADOOP_VERSION=${HADOOP_VERSION}' >> ~/.bashrc
    echo 'export HADOOP_HOME=${HADOOP_HOME}' >> ~/.bashrc
    echo 'export HADOOP_CONF_DIR=${HADOOP_CONF_DIR}' >> ~/.bashrc
    source ~/.bashrc
}

install_spark() {
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
	tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
    mv /usr/$SPARK_PACKAGE $SPARK_HOME 
    chown -R root:root $SPARK_HOME

    echo 'export SPARK_VERSION=${SPARK_VERSION}' >> ~/.bashrc
    echo 'export SPARK_HOME=${SPARK_HOME}' >> ~/.bashrc
    echo 'export SPARK_PACKAGE=${SPARK_PACKAGE}' >> ~/.bashrc
    source ~/.bashrc
}



echo "STARTING INSTALLATION OF PYTHON"
install_python

echo "STARTING INSTALLATION OF JAVA"
install_java

echo "STARTING INSTALLATION OF HADOOP"
install_hadoop

echo "STARTING INSTALLATION OF SPARK"
install_spark