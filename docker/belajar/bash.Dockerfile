FROM ubuntu:xenial AS base
RUN apt update -y && apt upgrade -y && \
    echo 'this is file test' >> /tmp/files

FROM alpine:latest AS packager
COPY --from=base /tmp/files /tmp/files
