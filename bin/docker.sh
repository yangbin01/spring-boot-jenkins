#!/usr/bin/env bash

PORJECT_NAME=$1

curPath=$(readlink -f "$(dirname "$0")")

cd $curPath

appJar=$(ls | grep *.jar)

docker build --build-arg JAR_FILE=${appJar} -t ${PORJECT_NAME} .

existsContainer=$(docker ps -a | grep "${PORJECT_NAME}" | awk '{print $1}')

echo $existsContainer
if [ -n "${existsContainer}" ]; then
  docker rm -f ${existsContainer}
fi

docker run --name ${PORJECT_NAME} -d -p 8090:8090 ${PORJECT_NAME}