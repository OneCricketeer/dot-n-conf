SPARK_VERSION=`ls /usr/local/Cellar/apache-spark/ | sort | tail -1`
if which pyspark > /dev/null; then
  export SPARK_HOME="/usr/local/Cellar/apache-spark/$SPARK_VERSION/libexec"
  # export PYSPARK_SUBMIT_ARGS="--master local[2]"
  # Add the PySpark classes to the Python path:
  export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
  export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.9-src.zip:$PYTHONPATH"
fi
