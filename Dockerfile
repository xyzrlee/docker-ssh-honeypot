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
  && git clone --depth=1 --single-branch https://github.com/droberson/ssh-honeypot.git /repo \
  && cd /repo \
  && make

# ------------------------------------------------

FROM alpine

COPY --from=builder /repo/bin/ssh-honeypot /usr/local/bin/ssh-honeypot
COPY entrypoint.sh /entrypoint.sh

RUN set -ex \
  && apk add --update --no-cache \
    libssh-dev \
    json-c-dev \
    openssh \
    sudo \
  && ssh-honeypot -h

ENTRYPOINT [ "/entrypoint.sh" ]

