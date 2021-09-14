FROM alpine:edge
RUN apk update && \
    apk upgrade && \
    apk add bash \
            vim \
            iputils \
            busybox-extras

COPY entrypoint.sh /entrypoint.sh

ENV SERVICE_NAME=${SERVICE_NAME} SERVICE_PORT=${SERVICE_PORT}

ENTRYPOINT ["/entrypoint.sh"]
