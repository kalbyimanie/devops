FROM nginx:stable-alpine  AS base_layer
RUN apk --update --no-cache add net-tools \
                                vim \
                                bash && \
                            rm -rf /var/cache/apk/*
