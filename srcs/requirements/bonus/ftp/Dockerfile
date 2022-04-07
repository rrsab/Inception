FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vsftpd && \
    apt-get install openssl && \
    apt-get install  jq -y && \
    apt-get install  curl -y && \
    apt-get install openssh-server -y

RUN mkdir -p  var/run/vsftpd/empty
RUN adduser --home /var/www/html 'ftpsalyce'
RUN echo "ftpsalyce:ftpsalyce" | chpasswd


ADD ./data/vsftpd.conf /etc/vsftpd.conf

# SSL
RUN mkdir /etc/vsftpd/
RUN mkdir /etc/vsftpd/ssl/

RUN  openssl req \
    -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/vsftpd/ssl/vsftpd.key \
    -out /etc/vsftpd/ssl/vsftpd.crt \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21/OU=School/CN=localhost"

ADD ./data/start.sh /etc/vsftpd/start.sh
RUN chmod -R 755 /etc/vsftpd/start.sh

EXPOSE 20 21 60007

CMD ["/etc/vsftpd/start.sh"]