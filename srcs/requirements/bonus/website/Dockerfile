FROM debian:buster

# Download Nginx
 RUN apt-get update && apt-get upgrade -y && \
     apt-get install nginx openssl php-gd php-xml -y procps





#Script for ssl

RUN mkdir /etc/nginx/ssl/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
   -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21/OU=School/CN=localhost"


COPY ./conf/site.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
RUN rm /etc/nginx/sites-enabled/default

COPY ./site/ /var/www/html/site/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]