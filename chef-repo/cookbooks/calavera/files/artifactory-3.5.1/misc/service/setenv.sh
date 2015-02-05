#!/bin/bash

. /etc/opt/jfrog/artifactory/default
echo "Max number of open files: `ulimit -n`"
echo "Using ARTIFACTORY_HOME: $ARTIFACTORY_HOME"
echo "Using ARTIFACTORY_PID: $ARTIFACTORY_PID"
export CATALINA_OPTS="$CATALINA_OPTS $JAVA_OPTIONS -Dartifactory.home=$ARTIFACTORY_HOME"
export CATALINA_PID=$ARTIFACTORY_PID
export CATALINA_HOME="$TOMCAT_HOME"

createDir() {
    if [ ! -e "$1" ]; then
        echo "Creating directory $1"
        mkdir "$1"
    fi
}

createDir "$ARTIFACTORY_HOME/logs"

for d in $TOMCAT_HOME/{logs,temp,work}; do
    createDir "$(readlink -f $d)"
done

