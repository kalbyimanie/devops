FROM ubuntu:21.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update -y
RUN apt-get install -y \
    vim && \
    mkdir -p /usr/share/man && \
    apt-get install -y openssh-server

FROM base AS service
EXPOSE 22


RUN echo 'root:root' | chpasswd && \
    mkdir -p /var/run/sshd && \
    mkdir -p /root/.ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    echo 'root:root' |chpasswd && \
    systemctl enable ssh.service && \
    service ssh start
COPY ./scripts/ssh-chroot.sh /root/scripts/ssh-chroot.sh
RUN chmod +x /root/scripts/ssh-chroot.sh && \
    bash /root/scripts/ssh-chroot.sh
CMD ["/usr/sbin/sshd", "-D"]
