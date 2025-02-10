FROM openjdk:22-jdk-slim-buster
EXPOSE 8080
WORKDIR /app
ARG JAR_FILE=mktplace-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} /app/mktplace.jar
ENTRYPOINT ["java", "-jar", "mktplace.jar"]
