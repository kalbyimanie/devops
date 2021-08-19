FROM ubuntu:xenial
WORKDIR /
ENV PATH=${PATH}:/home
COPY app/hello.sh /home/hello.sh
RUN chmod u+x /home/hello.sh
CMD [ "hello.sh" ]
