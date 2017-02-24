#!/bin/bash

JMXPATH=${JMXPATH:-jmxfetch}
JMX_BRANCH=${JMX_BRANCH:-master}

set -e

if ! git -C $JMXPATH rev-parse 2>/dev/null;
then
    git clone --branch $JMX_BRANCH --depth 1 https://github.com/DataDog/jmxfetch.git $JMXPATH
fi

cd $JMXPATH
if [ "$(git branch | grep -e '^\*' | cut -f2 -d' ')" != "$JMX_BRANCH" ];
then
    if [ -f $(git rev-parse --git-dir)/shallow ];
    then
        git fetch --unshallow
    else
        git fetch
    fi
    git checkout $JMX_BRANCH
else
    git pull
fi

mvn clean compile assembly:single && cd -

cp /$JMXPATH/target/*.jar /pkg
cd /pkg && jar xf $(find /$JMXPATH/target -type f -name '*.jar' -exec ls -1rt "{}" \+  | tail -n 1) META-INF/MANIFEST.MF && cd -

set +e
