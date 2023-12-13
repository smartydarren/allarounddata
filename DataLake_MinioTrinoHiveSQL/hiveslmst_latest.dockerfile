FROM openjdk:22-slim-bookworm
#FROM openjdk@sha256:f28f4255b082053bf5a3c922a8fd8c466d0ae8bd4f2a0ed93ed3e528f2773bd8
LABEL maintainer="smartydarren@gmail.com"

#dos2unix - to change the end of line sequence to LF as we are running linux container built on windows 11 - docker desktop
RUN apt-get update && apt-get install dos2unix && \
    apt-get install -y netcat-traditional curl && apt-get clean

WORKDIR /opt

ENV entrypointfilename=entrypoint_latest

#File downloads
ENV METASTORE_VERSION=3.1.3
ENV HADOOP_VERSION=3.3.6
ENV awssdkbundle=1.12.583
ENV guava=32.1.3


ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -L https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \    
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    curl -L --output aws-java-sdk-bundle-${awssdkbundle}.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${awssdkbundle}/aws-java-sdk-bundle-${awssdkbundle}.jar && \
    curl -L --output guava-${guava}-jre.jar https://repo1.maven.org/maven2/com/google/guava/guava/${guava}-jre/guava-${guava}-jre.jar && \
    curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.1.0.tar.gz | tar zxf - && \
    curl -L --output mariadb-java-client-3.2.0.jar https://dlm.mariadb.com/3418100/Connectors/java/connector-java-3.2.0/mariadb-java-client-3.2.0.jar && \
    curl -L --output postgresql-42.6.0.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar && \    
    cp mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar ${HIVE_HOME}/lib/ && \
    cp mariadb-java-client-3.2.0.jar ${HIVE_HOME}/lib && \
    cp postgresql-42.6.0.jar ${HIVE_HOME}/lib && \
    # Replacing & updating the Google Library to latest jar in hive/lib file to avoid conflicts with hadoop classpath
    cp guava-${guava}-jre.jar ${HIVE_HOME}/lib/ && \
    # Replacing the aws-sdk-bundle with the latest release
    cp aws-java-sdk-bundle-${awssdkbundle}.jar ${HADOOP_HOME}/share/hadoop/tools/lib/ && \
    # Removing all downloaded files to reduce container size
    rm -rf ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.12.367.jar && \
    rm -rf hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz && \
    rm -rf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm -rf mysql-connector-j-8.1.0.tar.gz && \
    rm -rf mysql-connector-j-8.1.0.jar && \
    rm -rf postgresql-42.6.0.jar && \  
    rm -rf mariadb-java-client-3.2.0.jar && \
    rm -rf ${HIVE_HOME}/lib/guava-19.0.jar
   
COPY scripts/${entrypointfilename}.sh /${entrypointfilename}.sh
# Changing the end of line sequence to LF
RUN dos2unix /${entrypointfilename}.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /${entrypointfilename}.sh && chmod +x /${entrypointfilename}.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/${entrypointfilename}.sh"]


# docker build . --tag smartydarren/hive-standalonemetastore:latest -f ./hiveslmst_latest.dockerfile --no-cache