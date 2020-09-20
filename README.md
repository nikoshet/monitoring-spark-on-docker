# Monitoring Apache Spark and HDFS on Docker with Prometheus and Grafana

## Goal
The goal of this project is to:
- Create a Docker Container that runs Spark on top of HDFS
- Use Prometheus to get metrics from Spark applications and Node-exporter
- Use Grafana to display the metrics collected

## Configurations
- Hadoop Configurations for core-sites.xml and hadoop-env.sh are set [here]().
- Spark Configurations for spark-env.sh and spark-defaults.conf are set [here]().
- Spark/Hadoop versions and library paths are set [here]().

## Notes
- Spark version running is 3.0.1, and HDFS version is 3.2.0.
- For all available metrics for Spark monitoring see [here](https://spark.apache.org/docs/2.2.0/monitoring.html#metrics).
- The containerized environment consists of a Master, a Worker, a DataNode, a NameNode and a SecondaryNameNode.
- To track metrics across Spark apps, appName needs to be set up or else the spark.metrics.namespace will be spark.app.id that changes after every invocation of the app.
- Main Python Application running is app.py that is an example application computing number pi. For your own application/use of HDFS please do changes accordingly.

## Usage
Assuming that Docker is installed, simply execute the following command to build and run the Docker Containers:
```
docker-compose build && docker-compose up
```
## Screenshots
- Example dashboard for Spark Metrics:
<div style="display:block;margin:auto;height:80%;width:80%">
  <img src="./screenshot/spark-dashboard.png">
</div>
- All available services from Service Discovery in Prometheus:
<div style="display:block;margin:auto;height:40%;width:40%">
  <img src="./screenshot/services.png">
</div>

## Troobleshooting
Please file issues if you run into any problems.