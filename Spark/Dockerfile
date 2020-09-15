# Debian 9 (Stretch) Base Image
FROM debian:9-slim

LABEL mainteiner = nikoshet 'https://github.com/nikoshet/monitoring-spark-on-docker'

# Environment Variables
ENV LANG                    en_US.UTF-8
ENV LC_ALL                  en_US.UTF-8

# Copy Files
WORKDIR .
COPY install.sh ./

# Updates
RUN apt-get update \
    && apt-get upgrade -y \
# Set locales
    && export LANGUAGE=${LANG} \
    && export LANG=${LANG} \
    && apt-get install -y locales \
    #&& locale-gen ${LANG}  \
    && echo "export LANG=${LANG}" > /etc/profile.d/locale.sh \
    && dpkg-reconfigure locales \
# Bug fix for openjdk-8 on Debian
    && mkdir -p /usr/share/man/man1 \
# Installations
    #apt-get install -y \
    #   openjdk-8-jdk-headless \
    && apt-get install -y wget \
    && ls \
    && chmod +x *.sh \
    && ./install.sh \
# Cleaning
    && pt-get clean all \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Final Command
WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]