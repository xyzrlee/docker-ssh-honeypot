#!/bin/sh

CMD="$@"
echo "CMD=${CMD}"

set -e

mkdir -p /data /logs

if [ ! -f ${HONEYPOT_SSH_KEY_FILE} ]
then
    ssh-keygen -t rsa -f ${HONEYPOT_SSH_KEY_FILE} -q -N ""
fi

ls -l ${HONEYPOT_SSH_KEY_FILE}

ssh-honeypot ${CMD}
