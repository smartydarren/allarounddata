#!/bin/sh

export hiveversion="3.0.0"
export awsjavasdkbundle="aws-java-sdk-bundle-1.11.375.jar"
export hadoopaws="hadoop-aws-3.2.0.jar"
export HADOOP_HOME=/opt/hadoop-3.2.0
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/${awsjavasdkbundle}:${HADOOP_HOME}/share/hadoop/tools/lib/${hadoopaws}
export JAVA_HOME=/usr/local/openjdk-8
export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}
# check the above classpath jar file locations in the tar.gz by opening it with winrar and set the versions manually[aws-java-sdk-bundle-1.12.367.jar, hadoop-aws-3.3.6.jar ]

MYSQL='mysql'
POSTGRES='postgres'

if [ "${METASTORE_TYPE}" = "${MYSQL}" ]; then
  echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 3306 ..."
  while ! nc -z ${METASTORE_DB_HOSTNAME} 3306; do
    sleep 1
  done

  echo "Database on ${METASTORE_DB_HOSTNAME}:3306 started"
  echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:3306"

  /opt/apache-hive-metastore-${hiveversion}-bin/bin/schematool -initSchema -dbType mysql
  /opt/apache-hive-metastore-${hiveversion}-bin/bin/start-metastore
fi


if [ "${METASTORE_TYPE}" = "${POSTGRES}" ]; then
  echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 5432 ..."
  while ! nc -z ${METASTORE_DB_HOSTNAME} 5432; do
    sleep 1
  done

  echo "Database on ${METASTORE_DB_HOSTNAME}:5432 started"
  echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:5432"

  /opt/apache-hive-metastore-${hiveversion}-bin/bin/schematool -initSchema -dbType postgres
  /opt/apache-hive-metastore-${hiveversion}-bin/bin/start-metastore
fi