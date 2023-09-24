#!/bin/sh

export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}

echo "Accessing shell script..."
NAME="Darren Quadros"
echo $NAME
echo ${NAME}
echo "${NAME}"
echo ${METASTORE_DB_HOSTNAME}
echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:3306"
echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 3306 ..."
