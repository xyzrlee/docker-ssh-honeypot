#!/bin/sh

mkdir -p /data /logs

SSH_KEY_FILE=/data/ssh-honeypot.rsa

if [ ! -f ${SSH_KEY_FILE} ]
then
    ssh-genkey -t rsa -f ${SSH_KEY_FILE} -q -N ""
fi

sudo ssh-honeypot -p 22 -r ${SSH_KEY_FILE} 
