#!/bin/bash

echo "STARTING APP"

# Run Spark example
#${SPARK_HOME}/bin/spark-submit --class org.apache.spark.examples.JavaSparkPi ${SPARK_HOME}/examples/jars/spark-examples_2.12-3.0.1.jar

# Run custom python app
#${SPARK_HOME}/bin/pyspark 
${SPARK_HOME}/bin/spark-submit app.py
