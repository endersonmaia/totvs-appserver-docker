FROM centos:7.3.1611

LABEL maintainer "Enderson Maia <endersonmaia@gmail.com>"

RUN yum -y update \
    && yum -y install \
        dmidecode \
        fontconfig.i686 \
        glib2.i686 \
        glibc.i686 \
        libstdc++.i686 \
        libuuid.i686 \
        unzip \
        wget \
    && rm -rf /var/cache/yum/* \
    && yum clean all

RUN wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/bin/dumb-init

COPY /build /build

COPY 18-01-24-P12-APPSERVER_LINUX.ZIP /build/

RUN /build/setup.sh

EXPOSE 1234

VOLUME ["/totvs12/microsiga/protheus_data", "/totvs12/microsiga/protheus/apo/"]

WORKDIR /totvs12/microsiga/protheus/bin/appserver

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD [ "/usr/local/bin/my-init.sh" ]
