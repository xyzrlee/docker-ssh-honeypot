#!/bin/sh

mkdir -p /data /logs

if [ ! -f ${HONEYPOT_SSH_KEY_FILE} ]
then
    ssh-genkey -t rsa -f ${HONEYPOT_SSH_KEY_FILE} -q -N ""
fi

ls -l ${HONEYPOT_SSH_KEY_FILE}

ssh-honeypot $@
