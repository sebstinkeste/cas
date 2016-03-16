![alt text](https://www.apereo.org/sites/default/files/styles/project_logo/public/projects/logos/cas_max_logo_0.png?itok=uD4hQ5-h)

Central	 Authentification Service image build with tomcat:7.0 and java:7-jdk Docker images 

## Pull Docker image
```
docker pull sebstinkeste/cas:3.5.3
```

## build and run the Docker image
```
docker run -it sebstinkeste/cas:3.5.3
```
you can test it by visiting http://container_IP/cas in a browser

## Tomcat environment variables

```
CATALINA_HOME: /usr/local/tomcat
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
```

