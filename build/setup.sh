#!/usr/bin/env bash
set -e
set -x

TOTVS_PATH=/totvs12/microsiga

mkdir -p $TOTVS_PATH/protheus/{apo,bin/appserver}

unzip -j /build/18-01-24-P12-APPSERVER_LINUX.ZIP "appserverLinux/*" -d $TOTVS_PATH/protheus/bin/appserver/

cd $TOTVS_PATH/protheus/bin/appserver/

for file in $(ls *.tar.gz); do
  tar -xvzf $file -C ./
  rm -vf $file;
done

chmod 777 $TOTVS_PATH/protheus/bin/appserver/*.so

echo $TOTVS_PATH/"protheus/bin/appserver/" > /etc/ld.so.conf.d/appserver64-libs.conf
/sbin/ldconfig

cp /build/my-init.sh /usr/local/bin/my-init.sh
cp /build/appserver.ini $TOTVS_PATH/protheus/bin/appserver/

rm -rf /build
