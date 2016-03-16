FROM java:7-jdk
FROM tomcat:7.0

MAINTAINER Stinkeste Sébastien

RUN apt-get update && apt-get install -y nano vim wget  default-jdk && \ 
    keytool -keystore keystore -keysize 2048 -alias tomcat -genkey -keyalg RSA -keypass password -storepass password -dname "CN=Unknown, OU=Unknown, O=Unknown,L=Unknown, ST=Unknown, C=Unknown"
    # keytool -genkey -alias tomcat -dname "CN=cas.univ-xxx.fr,OU=X,O=Y,L=Z,S=XY,C=YZ" -keyalg RSA -keypass password -storepass password -keystore cacerts

ENV MAVEN_VERSION apache-maven-3.3.9
ENV CAS_VERSION v3.5.3
ENV CAS_DIR_NAME cas-3.5.3


RUN wget http://apache.mindstudios.com/maven/maven-3/3.3.9/binaries/${MAVEN_VERSION}-bin.tar.gz && \
    tar -xvf ${MAVEN_VERSION}-bin.tar.gz && \
    rm -rf ${MAVEN_VERSION}-bin.tar.gz && \
    cd ${MAVEN_VERSION} && \ 
    cp -r bin conf lib boot /usr/local/
    

WORKDIR /usr/local
RUN wget https://github.com/Jasig/cas/archive/${CAS_VERSION}.tar.gz && \
    tar -xvf ${CAS_VERSION}.tar.gz && \
    rm -rf ${CAS_VERSION}.tar.gz 
COPY pom.xml /usr/local/tomcat/conf/pom.xml
COPY server.xml /usr/local/tomcat/conf/server.xml


WORKDIR /usr/local/cas-3.5.3/cas-server-webapp/
COPY pom.xml /usr/local/cas-3.5.3/cas-server-webapp/pom.xml
COPY deployerConfigContext.xml ./src/main/webapp/WEB-INF/deployerConfigContext.xml
RUN mvn install && \
    cp target/cas.war /usr/local/tomcat/webapps


WORKDIR /usr/local/tomcat/

EXPOSE 80

CMD [ "bin/catalina.sh", "run"]






