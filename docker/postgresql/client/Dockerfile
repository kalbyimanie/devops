FROM alpine:3.18.4
RUN apk --no-cache add bash \
    postgresql12-client \
    vim \
    sudo
ENV HOST=${HOST}, PORT=${PORT}, USER=${USER}, PASS=${PASS}

CMD ["/bin/bash", "-c", "psql postgres://${USER}:${PASSWORD}@${HOST}:${PORT}/"]