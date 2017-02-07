#!/bin/bash

JMXPATH=${JMXPATH:-jmxfetch}

set -e

if ! git -C $JMXPATH rev-parse 2>/dev/null;
then
    git clone --depth 1 https://github.com/DataDog/jmxfetch.git $JMXPATH
fi

cd $JMXPATH && git pull && mvn clean compile assembly:single && cd -

cp /$JMXPATH/target/*.jar /pkg

set +e
