FROM ubuntu:20.04
RUN apt update 

ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y ldap-utils vim sssd-ldap libpam-ldapd ca-certificates libnss-ldap libpam-sss
RUN update-ca-certificates - update /etc/ssl/certs and ca-certificates.crt

COPY ldap-vars.env /ldap-vars.env
RUN mkdir -p /etc/sssd
COPY sssd.conf.sh /etc/sssd/sssd.conf.sh
WORKDIR /etc/sssd
RUN bash ./sssd.conf.sh && rm -f ./sssd.conf.sh && chmod 600 ./sssd.conf
WORKDIR /
RUN chmod 700 /root

COPY startup.sh /startup.sh
COPY test.sh.sh /root/test.sh.sh
RUN echo services: files sss >> /etc/nsswitch.conf
# RUN echo SELINUX=disabled > /etc/selinux/config
COPY mk-pw.sh /mk-pw.sh
RUN bash /mk-pw.sh && rm -f /mk-pw.sh
RUN chmod 600 /ldap-vars.env
CMD ["bash","/startup.sh"]
