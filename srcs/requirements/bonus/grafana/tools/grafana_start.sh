#!/bin/sh
#service php7.3-fpm start

#service php7.3-fpm stop ;

#exec php-fpm7.3 --nodaemonize

#/etc/init.d/grafana-server restart
#/etc/init.d/grafana-server start

cp /sample.yaml /etc/grafana/provisioning/datasources/
/etc/init.d/grafana-server restart
/etc/init.d/grafana-server start
/etc/init.d/telegraf start

/etc/init.d/influxdb restart 

telegraf


#tail -f /dev/null