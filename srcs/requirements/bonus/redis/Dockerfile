FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get install redis-server php-redis -y

COPY ./tools/redis.conf /etc/redis/redis.conf
RUN chmod 640 /etc/redis/redis.conf

CMD redis-server --protected-mode no
