FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/saludBoyaca-1.0.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD sh -c "sed -i 's/port=\"8080\"/port=\"${PORT:-8080}\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"