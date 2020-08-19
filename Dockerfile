FROM openjdk:8-jdk-alpine
ARG JAR_FILE
ADD ${JAR_FILE} app.jar
ENV JAVA_OPTS=""
EXPOSE 8090
ENTRYPOINT exec java $JAVA_OPTS -jar /app.jar