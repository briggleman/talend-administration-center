#!/bin/bash
sed -e 's/\[\%MYSQL_URL\%\]/'"$MYSQL_HOST"':'"$MYSQL_PORT"'\/'"$MYSQL_DB"'/' \
    -e 's/\[\%MYSQL_USER\%\]/'"$MYSQL_USER"'/' \
    -e 's/\[\%MYSQL_PASSWORD\%\]/'"$MYSQL_PASSWORD"'/' <${CATALINA_HOME}/conf/server.xml >${CATALINA_HOME}/conf/new.xml
rm ${CATALINA_HOME}/conf/server.xml
cp ${CATALINA_HOME}/conf/new.xml ${CATALINA_HOME}/conf/server.xml
rm ${CATALINA_HOME}/conf/new.xml
cd ${CATALINA_HOME}/database
sh startup.sh > /dev/null 2>&1 < /dev/null &
cd -
cd ${CATALINA_HOME}/bin
sh catalina.sh run
