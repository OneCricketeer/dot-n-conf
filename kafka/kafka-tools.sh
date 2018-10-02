#!/usr/bin/env bash
##
# Source this in your .bashrc
##

set -o pipefail

kafka_avro_schema_id() {
  if [ $# -ne 2 ]; then
    echo "Usage $0 <bootstrap-server> <topic[:part:[:offset]]>"
    return 1
  fi

  local BOOTSTRAP=$1
  local TOPIC_PART_OFFSET=$2
  local IFS=\:
  read topic part offset <<< "$TOPIC_PART_OFFSET"

  CONSUME_ONE="kafka-console-consumer --bootstrap-server $BOOTSTRAP --topic $topic --max-messages 1"
  if [ ! -z $part ]; then
    CONSUME_ONE="$CONSUME_ONE --partition $part"
  fi
  if [ ! -z $offset ]; then
    CONSUME_ONE="$CONSUME_ONE --offset $offset"
  fi

  local IFS=' '
  eval "$CONSUME_ONE" |\
    hexdump | head -n 1 | cut -d' ' -f 5,6 | tr -ds '[[:space:]]' '' |\
    { IFS= read -r schemaId; printf '%s\n' "$((16#${schemaId}))"; }
}

kafka_avro_key_schema_id() {
  if [ $# -ne 2 ]; then
    echo "Usage $0 <bootstrap-server> <topic[:part:[:offset]]>"
    return 1
  fi

  local BOOTSTRAP=$1
  local TOPIC_PART_OFFSET=$2
  local IFS=\:
  read topic part offset <<< "$TOPIC_PART_OFFSET"

  CONSUME_ONE="kafka-console-consumer --bootstrap-server $BOOTSTRAP --topic $topic --max-messages 1 \
    --property print.key=true --property print.value=false"
  if [ ! -z $part ]; then
    CONSUME_ONE="$CONSUME_ONE --partition $part"
  fi
  if [ ! -z $offset ]; then
    CONSUME_ONE="$CONSUME_ONE --offset $offset"
  fi

  local IFS=' '
  eval "$CONSUME_ONE" |\
    hexdump | head -n 1 | cut -d' ' -f 5,6 | tr -ds '[[:space:]]' '' |\
    { IFS= read -r schemaId; printf '%s\n' "$((16#${schemaId}))"; }
}

kafka_describe_topic() {
  if [ $# -ne 3 ]; then
    echo "Usage $0 <zkQuorum> <brokers> <topic>"
    return 1
  fi

  local ZK_HOST=$1
  local BROKERS=$2

  echo "===> Topic Desciption"
  kafka-topics --describe --zookeeper $ZK_HOST --topic $3

  echo "===> Earliest Offsets"
  kafka-run-class kafka.tools.GetOffsetShell --time -2 --broker-list $BROKERS --topic $3 | sort
  echo "===> Latest Offsets"
  kafka-run-class kafka.tools.GetOffsetShell --time -1 --broker-list $BROKERS --topic $3 | sort

}
