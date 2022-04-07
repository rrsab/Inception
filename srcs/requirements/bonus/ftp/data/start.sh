#!/bin/bash

mkdir -p /home/${FTP_USER}
chown -R ${FTP_USER}":"${FTP_USER} /home/${FTP_USER}

echo ${FTP_USER} | tee -a /etc/vsftpd.userlist

/usr/sbin/vsftpd /etc/vsftpd.conf

