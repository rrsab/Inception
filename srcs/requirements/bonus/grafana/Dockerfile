FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y gnupg2 curl mc gpg wget
#RUN	apt-get install -y php-fpm php-mysql

# RUN curl https://packages.grafana.com/gpg.key | apt-key add -
# RUN apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
# RUN add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
# RUN curl https://repos.influxdata.com/influxdb.key |  apt-key add -

# RUN add-apt-repository "deb https://repos.influxdata.com/debian buster stable"

RUN wget -qO- https://repos.influxdata.com/influxdb.key |  apt-key add -
RUN echo "deb https://repos.influxdata.com/debian buster stable" |  tee -a /etc/apt/sources.list.d/influxdb.list
RUN apt-get update -y
RUN apt-get install influxdb telegraf -y

#RUN apt-get update -y
#RUN apt-get install influxdb telegraf -y
#RUN apt-get -y install grafana


# RUN mkdir -p /var/www/html/adminer/
# COPY ./tools/adminer.php /var/www/html/adminer/index.php
# RUN chown -R www-data:www-data /var/www/html

# COPY ./conf/php-fpm.conf /etc/php/7.3/fpm/
# COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
EXPOSE 3000 8086

COPY ./tools/influxdb.conf .
COPY ./tools/telegraf.conf .
COPY ./tools/setup.sh .
#COPY ./tools/start.sh .
COPY ./tools/sample.yaml .
RUN bash setup.sh

COPY ./tools/grafana_start.sh .
#CMD sh grafana_start.sh
CMD ["bash", "grafana_start.sh"]