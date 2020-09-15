# Debian Buster Base Image
FROM debian:buster-slim

LABEL mainteiner = nikoshet 'https://github.com/nikoshet/monitoring-spark-on-docker'

# Environment Variables
ENV LANG                     en_US.UTF-8

# Copy Files
WORKDIR .
COPY install.sh ./

# Set locales
RUN apt-get install -y locales \
    && locale-gen ${LANG} \
    && /usr/sbin/update-locale LANG=${LANG} \
# Updates
    && apt-get update \
    && apt-get upgrade -y \
# Installations
    #apt-get install -y \
    #   openjdk-8-jdk-headless \
    && ls \
    && ./install.sh \
# Cleaning
    && pt-get clean all \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Final Command
WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]