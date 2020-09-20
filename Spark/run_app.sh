#!/bin/bash

echo "STARTING APP"

# Run Spark example
#${SPARK_HOME}/bin/spark-submit --class org.apache.spark.examples.JavaSparkPi ${SPARK_HOME}/examples/jars/spark-examples_2.12-3.0.1.jar


# Run custom python app with enabled metrics for Prometheus
#${SPARK_HOME}/bin/pyspark 
${SPARK_HOME}/bin/spark-submit app.py \
    --conf spark.ui.prometheus.enabled=true \
    --conf spark.executor.processTreeMetrics.enabled=true \
    --conf spark.metrics.conf=${SPARK_HOME}/conf/metrics.properties