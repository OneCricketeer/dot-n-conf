
ROOTDIR=/usr/local/Cellar
if [ -z ${ROOTDIR-x} ]; then 
    ROOTDIR=/opt
    echo "Profile error: ROOTDIR not defined. Setting to $ROOTDIR"
fi

SPARK_FOLDER=apache-spark@1.6
SPARK_VERSION=`ls ${ROOTDIR}/$SPARK_FOLDER | sort | tail -1`
export SPARK_HOME="${ROOTDIR}/$SPARK_FOLDER"
# When using Homebrew, go into libexec
export SPARK_HOME="$SPARK_HOME/$SPARK_VERSION/libexec"
export PATH="${PATH}:$SPARK_HOME/bin"

if which pyspark > /dev/null; then 
  # export PYSPARK_SUBMIT_ARGS="--master local[2]"
  # Add the PySpark classes to the Python path:
  export PYTHONPATH="$SPARK_HOME/python/:$PYTHONPATH"
  export PYTHONPATH="$(find $SPARK_HOME/python/lib -name 'py4j*.zip'):$PYTHONPATH"
fi
