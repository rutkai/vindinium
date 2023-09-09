FROM node:16 as frontend-build

WORKDIR /app
COPY ./client ./client

RUN npm install -g grunt-cli
RUN cd client &&\
    ./build.sh


FROM rutkai/sbt:0.13.8-oracle-jre-8 as backend-build

WORKDIR /app
COPY . .
COPY --from=frontend-build /app/public /app/public

RUN cp conf/application.conf.dist conf/application.conf &&\
    sed -i s/localhost:27017/mongodb:27017/g conf/application.conf &&\
    mv docker-artifacts/.ivy2 /root/ &&\
    mv docker-artifacts/.sbt /root/
RUN sbt compile dist
RUN unzip target/universal/vindinium-1.1.zip


FROM eclipse-temurin:8-focal

WORKDIR /app

COPY --from=backend-build /app/vindinium-1.1 /app
RUN chown -R www-data: /app

EXPOSE 9000
USER www-data

CMD ["bin/vindinium"]
