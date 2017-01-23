#!/usr/bin/env bash
set -e
set -x

TOTVS_PATH=/totvs11/microsiga

mkdir -p $TOTVS_PATH/protheus/{apo,bin/appserver}

unzip -j /build/16-12-15-P11_APPSERVER_LINUX_X64.ZIP "appserverLinux_x64/*" -d $TOTVS_PATH/protheus/bin/appserver/

cd $TOTVS_PATH/protheus/bin/appserver/

for file in $(ls *.tar.gz); do 
  tar -xvzf $file -C ./
  rm -vf $file;
done

chmod 777 $TOTVS_PATH/protheus/bin/appserver/*.so

cp /build/docker-entrypoint.sh /
cp /build/appserver.ini $TOTVS_PATH/protheus/bin/appserver/

#rm -rf /build