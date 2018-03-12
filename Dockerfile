FROM hasholding/alpine-base

LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"

ARG VERSION=1.5.2
ENV TELEGRAF_CONFIG_PATH /etc/telegraf.conf
VOLUME /shared
WORKDIR /tmp
RUN apk add --no-cache wget 
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-${VERSION}-static_linux_amd64.tar.gz -O telegraf.tar.gz
RUN tar xvfz telegraf.tar.gz  -C /bin  --strip 2
RUN rm -r *
COPY telegraf.conf /etc/telegraf.conf
COPY entrypoint.sh /bin
EXPOSE 8125/udp 8092/udp 8094
ENTRYPOINT ["/bin/entrypoint.sh"]
