FROM alpine

LABEL maintainer="cyberjacob@gmail.com"

EXPOSE 443
VOLUME /data

ADD webmin-1.850.tar.gz /tmp/webmin-1.850.tar.gz

ENV config_dir /data
ENV var_dir    /var/webmin.
ENV perl       /usr/bin/perl
ENV port       443
ENV login      admin
ENV password   admin
ENV ssl        1
ENV atboot     0

RUN apk update && apk add perl tar && rm -r /var/cache/
RUN cd /tmp && tar zxf webmin-1.850.tar.gz && cd webmin-1.850 && ./setup.sh /usr/local/webmin

# TODO: Startup script to copy default config
ENTRYPOINT /usr/local/webmin/miniserv.pl /data/miniserv.conf
