# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps
COPY --from=build /app/target/*.war ./ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
