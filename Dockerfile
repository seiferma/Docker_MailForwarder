FROM debian:11-slim AS builder

RUN apt-get update && \
    apt-get install -y golang ca-certificates git

RUN go get -u gitlab.com/shackra/goimapnotify && \
    go install -v gitlab.com/shackra/goimapnotify


FROM debian:11-slim

RUN apt-get update && \
    apt-get install -y fdm msmtp ca-certificates netbase gosu && \
    gosu nobody true && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/go/bin/goimapnotify /usr/bin/

ENV INIT_DIR=/config/initial \
    DATA_DIR=/data/writable
RUN INIT_CONTAINER=$(dirname $INIT_DIR) && \
    mkdir -p $INIT_CONTAINER && \
    chmod 700 $INIT_CONTAINER && \
    INIT_CONTAINER= && \
    DATA_CONTAINER=$(dirname $DATA_DIR) && \
    mkdir -p $DATA_CONTAINER && \
    chmod 700 $DATA_CONTAINER && \
    DATA_CONTAINER=

VOLUME ["${INIT_DIR}", "${DATA_DIR}"]

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/process.sh", "start"]
