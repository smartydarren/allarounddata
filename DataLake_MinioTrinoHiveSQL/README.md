Latest- configuration
-----------
Debian 12 bookworm docker container with Java 22 early access
HADOOP_VERSION=3.2.0
METASTORE_VERSION=3.0.0
google jar and aws-sdk-bundle as on nov 2023
Trino container
Minio container
mysql container


c1- configuration
-----------
Java 8 docker container
mysql - docker.io/mysql:latest
HADOOP_VERSION=3.2.0
METASTORE_VERSION=3.0.0

mysql - 8.2.0 
minio - 






#      ---------------------------
# Building a local DataLake Setup using Docker on Windows 11
# COPY scripts/hadoop-${HADOOP_VERSION}.tar.gz /opt/hadoop-${HADOOP_VERSION}.tar.gz
# RUN tar -zxf /opt/hadoop-${HADOOP_VERSION}.tar.gz


# docker container run -d -p 9083:9083 --name hivestandalonemetastore smartydarren/hive-standalonemetastore:latest
# docker container run -d -p 9083:9083 --name hivestandalonemetastore --env METASTORE_DB_HOSTNAME=mysql --env METASTORE_TYPE=mysql --env SERVICE_NAME=metastore smartydarren/hive-standalonemetastore:latest
# docker container exec --interactive --tty --workdir=/opt smartydarren/hive-standalonemetastore:3.1.3 /bin/sh
# docker container rm --force $(docker ps --quiet --all)
# docker container run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hivebeta1 apache/hive:4.0.0-beta-1
# docker container run -d -p 9083:9083 --env SERVICE_NAME=metastore --name metastore-standalone hive:latest
# Bitsondatadev Image works fine even while dropping schema - https://github.com/bitsondatadev/hive-metastore/blob/master/Dockerfile
# Bookworm is the latest debian version 12


# PLPT
# cd C:\Users\darre\OneDrive\Office\LEARNING\mycodepath\allarounddata\DataLake_MinioTrinoHiveSQL

# OLPT
# cd C:\Users\dquadros\OneDrive\Office\LEARNING\mycodepath\allarounddata\DataLake_MinioTrinoHiveSQL



# https://github.com/arempter/hive-metastore-docker
# https://techjogging.com/standalone-hive-metastore-presto-docker.html
# https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/4.0.0-beta-1/
# https://medium.com/analytics-vidhya/hive-installation-on-ubuntu-18-04-b3362dcadfb8
# https://techjogging.com/access-minio-s3-storage-prestodb-cluster-hive-metastore.html -- create tables

# Maria DB version 10.5.11 is the max that HiveMetastore works with, however note you will not be able to drop the schema once created.
# Maria DB version 10.5.8 is the max with which you can do everything, including dropping of schema.
# My recomendation would be to use latest MySQL version or Postgress Db, as I did not find any issues while dropping schemas.
# hiveimagesl="bitsondatadev/hive-metastore:latest"