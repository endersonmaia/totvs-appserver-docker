FROM centos:7

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



RUN DUMB_INIT_SHA256="37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9" \
    && wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
    && echo "37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9 */usr/bin/dumb-init" | sha256sum -c - \
    && chmod +x /usr/bin/dumb-init

COPY /build /build

ADD 19-02-15-P12_APPSERVER_BUILD-17.3.0.8_LINUX_X64.TAR.GZ /totvs12/microsiga/protheus/bin/appserver

RUN /build/setup.sh

EXPOSE 1234

VOLUME ["/totvs12/microsiga/protheus_data", "/totvs12/microsiga/protheus/apo/"]

WORKDIR /totvs12/microsiga/protheus/bin/appserver

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD [ "/usr/local/bin/my-init.sh" ]
