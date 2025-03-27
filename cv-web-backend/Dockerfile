
###
# Build Stage
###

FROM gradle:8.5-jdk17 AS builder

WORKDIR /app

# Copy only what's needed first to leverage Docker cache
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Download dependencies first (caching)
RUN ./gradlew dependencies

# Then copy the full source
COPY . .

# Run tests
# RUN ./gradlew clean test
RUN ./gradlew clean

# Build the Spring Boot fat jar
RUN ./gradlew bootJar

###
# Run Stage
###

FROM eclipse-temurin:17-jre


COPY --from=builder /app/build/libs/*.jar /app/app.jar

ENV USER=backend
RUN groupadd -g 35000 ${USER} && useradd -u 35000 -g ${USER} -d /app -m -s /bin/bash ${USER}
WORKDIR /app
RUN mkdir -p /app/logs && chown -R ${USER}:${USER} /app/logs
RUN touch /app/logs/app-json.log && chown ${USER}:${USER} /app/logs/app-json.log

ARG OTEL_AGENT_VERSION=2.13.3
RUN curl -SLo /app/opentelemetry-javaagent.jar \
https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_AGENT_VERSION}/opentelemetry-javaagent.jar \
&& ls -lah /app/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/app/opentelemetry-javaagent.jar"

USER ${USER}
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
