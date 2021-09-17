FROM ubuntu:xenial
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mysql-client
CMD ["/bin/bash", "-c", "tail -f /dev/null"]
