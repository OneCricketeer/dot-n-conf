
ROOTDIR=$CASKROOM_HOME
if [ -z ${ROOTDIR-x} ]; then 
    ROOTDIR=/opt 
    echo "Profile error: ROOTDIR not defined. Setting to $ROOTDIR"
fi

SPARK_FOLDER=apache-spark16
SPARK_VERSION=`ls ${ROOTDIR}/${SPARK_FOLDER}/ | sort | tail -1`
if which pyspark > /dev/null; then
  export SPARK_HOME="${ROOTDIR}/$SPARK_FOLDER/$SPARK_VERSION"
  # export PYSPARK_SUBMIT_ARGS="--master local[2]"
  # Add the PySpark classes to the Python path:
  export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
  py4j=$(find $SPARK_HOME -name 'py4j*.zip')
  export PYTHONPATH="$py4j:$PYTHONPATH"
fi
