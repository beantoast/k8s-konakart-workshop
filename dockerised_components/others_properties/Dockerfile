FROM alpine:3.9
RUN apk --no-cache add curl
#RUN curl -L "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=co.elastic.apm&a=elastic-apm-agent&v=LATEST" -o elastic-apm-agent.jar
RUN curl -L "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=co.elastic.apm&a=apm-agent-api&v=LATEST" -o apm-agent-api.jar
RUN curl -L -O "https://github.com/elastic/apm-agent-rum-js/releases/latest/download/elastic-apm-rum.umd.min.js"
FROM alpine:3.9
#RUN mkdir /usr/agent
RUN mkdir /usr/agent-rum
RUN mkdir /usr/agent-api
#COPY --from=0 elastic-apm-agent.jar /usr/agent
COPY --from=0 apm-agent-api.jar /usr/agent-api/
COPY --from=0 elastic-apm-rum.umd.min.js /usr/agent-rum/
# logging property
COPY ./konakart-logging.xml /usr/kk-properties/
# MainLayout html property
COPY ./MainLayout.jsp /usr/kk-properties/