#FROM node:16 as frontend-build
#
#WORKDIR /app
#COPY . .
#
#RUN npm install -g grunt-cli
#RUN cd client &&\
#    ./build.sh

FROM sbtscala/scala-sbt:eclipse-temurin-11.0.16_1.7.2_2.12.17

WORKDIR /app
COPY . .
#COPY --from=frontend-build /app/public /app/public

RUN cp conf/application.conf.dist conf/application.conf &&\
    sed -i s/localhost:27017/mongodb:27017/g conf/application.conf
RUN sbt compile

EXPOSE 9000

CMD ["sbt", "run"]
