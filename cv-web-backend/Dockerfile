FROM eclipse-temurin:17-jre

ENV APP_PORT="8080"
ENV USER=backend

RUN groupadd -g 35000 ${USER} && useradd -u 35000 -g ${USER} -d /app -m -s /bin/bash ${USER}
USER ${USER}

COPY build/libs/*.jar /app/app.jar
WORKDIR /app

CMD ["java", "-jar", "app.jar", "--spring.config.location=/app/config/application.yml"]
EXPOSE $APP_PORT