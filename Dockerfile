# setup working directory
FROM maven:3.5.3 AS build
RUN mkdir /app
WORKDIR /app

# maven build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

# deploy to tomcat server
FROM tomcat:9.0.44
COPY --from=build app/target/simplewebapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
