FROM debian:buster

# Download Nginx
RUN apt-get update && apt-get upgrade -y && \
    apt-get install nginx openssl php-gd php-xml -y procps &&\
    apt-get install net-tools &&\
    apt-get install curl -y

#Script for ssl

RUN mkdir /etc/nginx/ssl/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21/OU=School/CN=localhost"


COPY ./conf/site.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
RUN rm /etc/nginx/sites-enabled/default

# copy config
#COPY ./conf/default.conf /etc/nginx/sites-available/default
#COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN apt-get install gpg wget -y
RUN wget -qO- https://repos.influxdata.com/influxdb.key |  apt-key add -
RUN echo "deb https://repos.influxdata.com/debian buster stable" |  tee -a /etc/apt/sources.list.d/influxdb.list
RUN apt-get update -y
RUN apt-get install influxdb telegraf -y

COPY ./conf/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]