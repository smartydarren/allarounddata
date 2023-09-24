FROM openjdk:8u342-jre
LABEL maintainer="smartydarren@gmail.com"

#dos2unix - to change the end of line sequence to LF as we are running linux container built on windows 11 - docker desktop
RUN apt-get update && apt-get install dos2unix && \
    apt-get install -y netcat curl && apt-get clean

WORKDIR /opt

ENV HADOOP_VERSION=3.3.6
ENV METASTORE_VERSION=3.1.3

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -L https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \    
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.1.0.tar.gz | tar zxf - && \
    curl -L --output mariadb-java-client-3.2.0.jar https://dlm.mariadb.com/3418100/Connectors/java/connector-java-3.2.0/mariadb-java-client-3.2.0.jar && \
    curl -L --output postgresql-42.6.0.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar && \
    cp mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar ${HIVE_HOME}/lib/ && \
    cp mariadb-java-client-3.2.0.jar ${HIVE_HOME}/lib && \
    cp postgresql-42.6.0.jar ${HIVE_HOME}/lib && \
    # Replacing the Google Library jar in hive/lib file to avoid conflicts with hadoop classpath
    cp ${HADOOP_HOME}/share/hadoop/hdfs/lib/guava-27.0-jre.jar ${HIVE_HOME}/lib/ && \    
    rm -rf hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz && \
    rm -rf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm -rf mysql-connector-j-8.1.0.tar.gz && \
    rm -rf mysql-connector-j-8.1.0.jar && \
    rm -rf postgresql-42.6.0.jar && \  
    rm -rf mariadb-java-client-3.2.0.jar && \    
    rm -rf ${HIVE_HOME}/lib/guava-19.0.jar
   
COPY scripts/entrypoint.sh /entrypoint.sh
# Changing the end of line sequence to LF
RUN dos2unix /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]


# cd D:\LearnToCode\GitRepos\allarounddata\DataLake_MinioTrinoHiveSQL
# docker build . --tag smartydarren/hive-standalonemetastore:3.1.3 -f ./hivestandalonemetastore.dockerfile --no-cache
# docker container run -d -p 9083:9083 --name hivestandalonemetastore smartydarren/hive-standalonemetastore:3.1.3
# docker container run -d -p 9083:9083 --name hivestandalonemetastore --env METASTORE_DB_HOSTNAME=mysql --env METASTORE_TYPE=mysql --env SERVICE_NAME=metastore smartydarren/hive-standalonemetastore:3.1.3
# docker container exec --interactive --tty --workdir=/opt smartydarren/hive-standalonemetastore:3.1.3 /bin/sh
# docker container rm --force $(docker ps --quiet --all)

#
# docker container run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hivebeta1 apache/hive:4.0.0-beta-1
# docker container run -d -p 9083:9083 --env SERVICE_NAME=metastore --name metastore-standalone hive:latest