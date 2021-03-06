#!/usr/bin/env bash

GIT_ROOT=/Users/45ssg168/dev/spinnaker
ARTIFACT=fiat
SCRIPTS_DIR=/Users/45ssg168/dev/spinnaker/scripts

LOG_DIR=${GIT_ROOT}/logs
PID_FILE=${GIT_ROOT}/${ARTIFACT}.pid
ARTIFACT_DIR=${GIT_ROOT}/${ARTIFACT}
STOP_SCRIPT=${SCRIPTS_DIR}/${ARTIFACT}-stop.sh

function start() {
  if [ ! -d $LOG_DIR ]; then
    mkdir -p $LOG_DIR
  fi

 ${STOP_SCRIPT}

  pushd $ARTIFACT_DIR
  ./gradlew \
    2> ${LOG_DIR}/${ARTIFACT}.err \
    > ${LOG_DIR}/${ARTIFACT}.log &

  echo $! > $PID_FILE
  popd
}

start
