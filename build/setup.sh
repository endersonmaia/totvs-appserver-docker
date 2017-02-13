#!/usr/bin/env bash
set -e
set -x

TOTVS_PATH=/totvs12/microsiga

mkdir -p $TOTVS_PATH/protheus/{apo,bin/appserver}

unzip -j /build/17-02-07-P12_BINARIO_LINUX.ZIP "appserverLinux/*" -d $TOTVS_PATH/protheus/bin/appserver/

cd $TOTVS_PATH/protheus/bin/appserver/

for file in $(ls *.tar.gz); do 
  tar -xvzf $file -C ./
  rm -vf $file;
done

chmod 777 $TOTVS_PATH/protheus/bin/appserver/*.so

cp /build/docker-entrypoint.sh /
cp /build/appserver.ini $TOTVS_PATH/protheus/bin/appserver/

rm -rf /build