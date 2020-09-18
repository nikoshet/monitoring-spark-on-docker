import pyspark as ps
import random

spark = ps.sql.SparkSession.builder \
        .appName("rdd test") \
        .getOrCreate()

random.seed(1)
#import time
#time.sleep(1000)

def sample(p):
    x, y = random.random(), random.random()
    return 1 if x*x + y*y < 1 else 0
 
for x in range(0,100):
    count = spark.sparkContext.parallelize(range(0, 10000000)).map(sample) \
        .map(lambda x: x*2) \
        .map(lambda x: x - 10) \
        .map(lambda x: x + 10) \
        .reduce(lambda a, b: a + b)
 
    print("Pi is (very) roughly {}".format(4.0 * count / 10000000))