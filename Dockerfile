#
# Dockerfile for ssh-honeypot
#

FROM alpine AS builder

RUN set -ex \
 # Build environment setup
  && apk add --update \
    alpine-sdk \
    clang \
    git \
    libssh-dev \
    openssl \
    openssh \
    json-c-dev \
    libssh2-dev \
    libpcap-dev \
  && git clone --depth=1 --single-branch https://github.com/droberson/ssh-honeypot.git /repo \
  && cd /repo \
  && make

# ------------------------------------------------

FROM alpine

COPY --from=builder /repo/bin/ssh-honeypot /usr/local/bin/ssh-honeypot
COPY entrypoint.sh /entrypoint.sh

ENV HONEYPOT_SSH_KEY_FILE=/data/ssh-honeypot.rsa
ENV HONEYPOT_PORT=22222

RUN set -ex \
  && apk add --update --no-cache \
    libssh-dev \
    json-c-dev \
    libpcap-dev \
    openssh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD "-p ${HONEYPOT_PORT} -r ${HONEYPOT_SSH_KEY_FILE}"

