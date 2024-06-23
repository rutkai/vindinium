FROM node:16 as frontend-build

WORKDIR /app
COPY ./client ./client

RUN npm install -g grunt-cli
RUN cd client &&\
    ./build.sh


FROM sbtscala/scala-sbt:eclipse-temurin-jammy-11.0.22_7_1.9.9_3.4.0 as backend-build

WORKDIR /app
COPY . .
COPY --from=frontend-build /app/public /app/public

# Change the JDK to 8 instead of 11
RUN apt update && \
    apt install -y unzip openjdk-8-jdk-headless && \
    rm -rf /opt/java && \
    apt purge && apt autoclean

RUN cp conf/application.conf.dist conf/application.conf && \
    sed -i s/localhost:27017/mongodb:27017/g conf/application.conf && \
    rm -rf /home/sbtuser/.ivy2 && \
    rm -rf /home/sbtuser/.sbt && \
    mv docker-artifacts/.ivy2 /home/sbtuser/ && \
    mv docker-artifacts/.sbt /home/sbtuser/ && \
    ln -s /home/sbtuser/.ivy2 ~/.ivy2
RUN sbt compile dist
RUN unzip target/universal/vindinium-1.1.zip


FROM eclipse-temurin:8-focal

WORKDIR /app

COPY --from=backend-build /app/vindinium-1.1 /app
RUN chown -R www-data: /app

EXPOSE 9000
USER www-data

CMD ["bin/vindinium"]
