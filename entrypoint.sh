#!/bin/sh

mkdir -p /data /logs

if [ ! -f ${HONEYPOT_SSH_KEY_FILE} ]
then
    ssh-genkey -t rsa -f ${HONEYPOT_SSH_KEY_FILE} -q -N ""
fi

ssh-honeypot -p ${HONEYPOT_PORT} -r ${HONEYPOT_SSH_KEY_FILE} -u ${HONEYPOT_USER} $@
