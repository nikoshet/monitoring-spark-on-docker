#!/bin/bash

# Functions For Installation
install_python() {
    apt-get install -y python3 python3-setuptools
    ln -s /usr/bin/python3 /usr/bin/python 
    python --version
}

install_java() {
    apt-get install -y openjdk-8-jdk-headless
    java -version
}


install_hadoop() {
	wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz
    rm hadoop-${HADOOP_VERSION}.tar.gz
    rm -rf hadoop/share/doc/*
    chown -R root:root ${HADOOP_HOME}

    #   Set the datanode for the distributed filesystem
    echo "master" > ${HADOOP_HOME}/etc/hadoop/slaves
    #echo "slave" >> /home/user/hadoop-2.7.7/etc/hadoop/slaves

    # Edit core-site.xml to set hdfs default path to hdfs://master:9000                    #master
    CORE_SITE_CONTENT="\t<property>\n\t\t<name>fs.default.name</name>\n\t\t<value>hdfs://localhost:9000</value>\n\t</property>"
    INPUT_CORE_SITE_CONTENT=$(echo $CORE_SITE_CONTENT | sed 's/\//\\\//g')
    sed -i "/<\/configuration>/ s/.*/${INPUT_CORE_SITE_CONTENT}\n&/" ${HADOOP_HOME}/etc/hadoop/core-site.xml

    # Edit hdfs-site.xml to set hadoop file system parameters  
    HDFS_SITE_CONTENT="\t<property>\n\t\t<name>dfs.replication</name>\n\t\t<value>2</value>\n\t\t<description>Default block replication.</description>\n\t</property>
    \n\t<property>\n\t\t<name>dfs.namenode.name.dir</name>\n\t\t<value>/home/user/hdfsname</value>\n\t</property>
    \n\t<property>\n\t\t<name>dfs.datanode.data.dir</name>\n\t\t<value>/home/user/hdfsdata</value>\n\t</property>
    \n\t<property>\n\t\t<name>dfs.blocksize</name>\n\t\t<value>64m</value>\n\t\t<description>Block size</description>\n\t</property>
    \n\t<property>\n\t\t<name>dfs.webhdfs.enabled</name>\n\t\t<value>true</value>\n\t</property>
    \n\t<property>\n\t\t<name>dfs.support.append</name>\n\t\t<value>true</value>\n\t</property>"
    INPUT_HDFS_SITE_CONTENT=$(echo $HDFS_SITE_CONTENT | sed 's/\//\\\//g')
    sed -i "/<\/configuration>/ s/.*/${INPUT_HDFS_SITE_CONTENT}\n&/" ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml

    # Export JAVA_HOME variable for hadoop
	sed -i '/export JAVA\_HOME/c\export JAVA\_HOME=\/usr\/lib\/jvm\/java-8-openjdk-amd64' ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

}

install_spark() {
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_FOR_SPARK}.tgz
	tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_FOR_SPARK}.tgz
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_FOR_SPARK}.tgz
    chown -R root:root ${SPARK_HOME}

    # Set configuration for spark
    cd ${SPARK_HOME}/conf
    cp spark-env.sh.template spark-env.sh
    echo "SPARK_WORKER_CORES=2" >> spark-env.sh
	echo "SPARK_WORKER_MEMORY=2g" >> spark-env.sh
    echo "export SPARK_MASTER_HOST=localhost" >> spark-env.sh
	echo "JAVA_HOME=${JAVA_HOME}" >> spark-env.sh

    cp spark-defaults.conf.template spark-defaults.conf
	echo "spark.master\t\tspark://master:7077" >> spark-defaults.conf #localhost
	echo "spark.submit.deployMode\t\tclient" >> spark-defaults.conf
	echo "spark.executor.instances\t\t1" >> spark-defaults.conf
	echo "spark.executor.cores\t\t2" >> spark-defaults.conf
	echo "spark.executor.memory\t\t2g" >> spark-defaults.conf
	echo "spark.driver.memory\t\t512m" >> spark-defaults.conf
	
	echo "master" > slaves
	#echo "slave" >> slaves
    cd /
    mv metrics.properties ${SPARK_HOME}/conf/metrics.properties
}


echo "STARTING INSTALLATION OF PYTHON"
install_python

echo "STARTING INSTALLATION OF JAVA"
install_java

echo "STARTING INSTALLATION OF HADOOP"
install_hadoop

echo "STARTING INSTALLATION OF SPARK"
install_spark
