FROM nginx:stable-alpine  AS base_layer
RUN apk --update --no-cache add net-tools \
                                vim \
                                bash && \
                            rm -rf /var/cache/apk/*


FROM base_layer AS config_files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/web-app.conf /etc/nginx/conf.d/default.conf
