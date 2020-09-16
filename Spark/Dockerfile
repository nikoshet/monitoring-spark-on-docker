# Debian 9 (Stretch) Base Image
FROM debian:9-slim

LABEL mainteiner = nikoshet 'https://github.com/nikoshet/monitoring-spark-on-docker'

# Environment Variables
ENV LANG                        en_US.UTF-8
ENV LC_ALL                      UTF-8
# JAVA
ENV JAVA_HOME                   /usr/lib/jvm/java-8-openjdk-amd64/
# HADOOP
ENV HADOOP_VERSION              3.2.0
ENV HADOOP_VERSION_FOR_SPARK    3.2
ENV HADOOP_HOME                 hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR             ${HADOOP_HOME}/etc/hadoop
# SPARK
ENV SPARK_VERSION               3.0.1
ENV SPARK_HOME                  spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_FOR_SPARK}
ENV PYSPARK_PYTHON              python3

ENV PYTHONHASHSEED 1

# SPARK_PACKAGE
# Copy Files
WORKDIR .
COPY install.sh ./
COPY start.sh ./

# Updates
RUN apt-get update \
    && apt-get upgrade -y \
# Set locales
    && apt-get install -y locales \
    && dpkg-reconfigure locales \
    && echo "LC_ALL=${LANG}" >> /etc/environment \
    && echo "${LANG} ${LC_ALL}" >> /etc/locale.gen \
    && echo "LANG=${LANG}" > /etc/locale.conf \

    && locale-gen en_US.UTF-8 \

# Export Env Variables
    && export JAVA_HOME=${JAVA_HOME} \
    && export PATH=${JAVA_HOME}/jre/bin:$PATH \
    && export HADOOP_VERSION=${HADOOP_VERSION} \
    && export HADOOP_VERSION_FOR_SPARK=${HADOOP_VERSION_FOR_SPARK} \
    && export HADOOP_HOME=${HADOOP_HOME} \
    && export HADOOP_CONF_DIR=${HADOOP_CONF_DIR} \
    && export SPARK_VERSION=${SPARK_VERSION} \
    && export SPARK_HOME=${SPARK_HOME} \
    && export PYSPARK_PYTHON=${PYSPARK_PYTHON} \
# Bug fix for openjdk-8 on Debian
    && mkdir -p /usr/share/man/man1 \
# Installations
    #apt-get install -y \
    #   openjdk-8-jdk-headless \
    && apt-get install -y \
        wget \
        openssh-client \
        openssh-server \
        procps \
        sudo \
        scala \
        git \
    #&& ls \
    && chmod +x *.sh \
    && ./install.sh \
# Cleaning
    && apt-get clean all \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# passwordless ssh
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN mkdir -p /root/.ssh
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys


# Final Command
#WORKDIR $SPARK_HOME
ENTRYPOINT ["sh","-c","./start.sh && ${SPARK_HOME}/bin/spark-submit --class org.apache.spark.examples.JavaSparkPi ${SPARK_HOME}/examples/jars/spark-examples_2.12-3.0.1.jar"]

#ENTRYPOINT ["sh","-c","./start.sh && ${SPARK_HOME}/bin/pyspark"]