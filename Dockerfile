FROM centos:7.3.1611

LABEL maintainer "Enderson Maia <endersonmaia@gmail.com>"

RUN yum -y update && rm -rf /var/cache/yum/* && yum clean all

RUN yum -y update \
    && yum -y install glibc.i686 libstdc++.i686 libuuid.i686 unzip dmidecode \
    && rm -rf /var/cache/yum/* \
    && yum clean all

COPY /build /build

COPY 17-01-11-P12_BINARIO_LINUX.ZIP /build/

RUN /build/setup.sh

EXPOSE 1100

VOLUME ["/totvs11/microsiga/protheus_data", "/totvs11/microsiga/protheus/apo/"]

WORKDIR /totvs11/microsiga/protheus/bin/appserver

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "appserver" ]
