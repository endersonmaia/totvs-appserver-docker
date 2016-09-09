FROM centos:7.2.1511

MAINTAINER Enderson Maia <endersonmaia@gmail.com>

RUN yum -y update && rm -rf /var/cache/yum/* && yum clean all

RUN yum -y update \
    && yum -y install glibc.i686 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

ADD totvs11-rootfs.tgz /
COPY /build/docker-entrypoint.sh /
COPY /build/appserver.ini /totvs11/microsiga/protheus/bin/appserver/appserver.ini

EXPOSE 1100

VOLUME ["/totvs11/microsiga/protheus_data", "/totvs11/microsiga/protheus/apo/"]

WORKDIR /totvs11/microsiga/protheus/bin/appserver

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "appserver" ]
