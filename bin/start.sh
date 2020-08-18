#!/usr/bin/env bash

curPath=$(readlink -f "$(dirname "$0")")

appJar=$(find "${curPath}" -name spring-boot-jenkins*.jar)

pid=$(jps -l | grep spring-boot-jenkins*.jar | awk '{print $1}')

if [ "$pid" != "" ]; then
  kill -9 $pid
fi
nohup java -jar $appJar >/var/log/spring-boot-jenkins/app.log 2>&1 &