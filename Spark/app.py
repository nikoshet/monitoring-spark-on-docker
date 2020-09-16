import pyspark as ps
import random
 
spark = ps.sql.SparkSession.builder \
        .appName("rdd test") \
        .getOrCreate()
 
random.seed(1)
 
def sample(p):
    x, y = random.random(), random.random()
    return 1 if x*x + y*y < 1 else 0
 
for x in range(0,10):
    count = spark.sparkContext.parallelize(range(0, 10000000)).map(sample) \
             .reduce(lambda a, b: a + b)
 
    print("Pi is (very) roughly {}".format(4.0 * count / 10000000))