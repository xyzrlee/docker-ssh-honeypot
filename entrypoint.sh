#!/bin/sh

set -e

if [ -z "${HONEYPOT_SSH_KEY_FILE}" ]
then
    HONEYPOT_SSH_KEY_FILE="/data/ssh_honeypot.rsa"
fi

if [ -z "${HONEYPOT_PORT}" ]
then
    HONEYPOT_PORT=22
fi

if [ ! -f ${HONEYPOT_SSH_KEY_FILE} ]
then
    KEY_FILE_DIR=`dirname "${HONEYPOT_SSH_KEY_FILE}"`
    mkdir -p ${KEY_FILE_DIR}
    ssh-keygen -t rsa -f ${HONEYPOT_SSH_KEY_FILE} -q -N ""
fi

ls -l ${HONEYPOT_SSH_KEY_FILE}

CMD="-p ${HONEYPOT_PORT} -r ${HONEYPOT_SSH_KEY_FILE}"

if [ -n "${HONEYPOT_JSON_FILE}" ]
then
    CMD="${CMD} -j ${HONEYPOT_JSON_FILE}"
fi

echo "CMD=${CMD}"

ssh-honeypot ${CMD}

