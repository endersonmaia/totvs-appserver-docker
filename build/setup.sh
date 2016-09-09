#!/usr/bin/env bash
set -e
set -x

mkdir -p /totvs11/microsiga/protheus/{,apo/,include/,bin/appserver/,updates/{apo/,bin/{appserver/,smartclient/},pak/,ptm/,upd/}}

rpm -Uvh --nodeps /build/files/totvs11microsigaprotheus-systemload-bra-11.0-1.i586.rpm
rpm -Uvh --nodeps /build/files/totvs11microsigaprotheus-systemload-general-por-11.0-1.i586.rpm
rpm -Uvh --nodeps /build/files/totvs11microsigaprotheus-data-11.0-1.i586.rpm 
mv /build/files/15-12-01-BRA-EUA-PAR-URU-TTTP110.RPO /totvs11/microsiga/protheus/apo/tttp110.apo
unzip /build/files/15-12-01-UPDATE_BRA-EUA-PAR-URU-TTTP110.ZIP 15-11-30-update_bra-eua-par-uru-tttp110.upd -d /totvs11/microsiga/protheus/updates/upd
unzip /build/files/15-12-02-P11_APPSERVER_LINUX_X64.ZIP appserverLinux_x64/appsrvlinux_x64.tar.gz appserverLinux_x64/libctreetmp_x64.tar.gz -d /tmp/
tar -xvzf /tmp/appserverLinux_x64/appsrvlinux_x64.tar.gz -C /totvs11/microsiga/protheus/bin/appserver/
tar -xvzf /tmp/appserverLinux_x64/libctreetmp_x64.tar.gz -C /totvs11/microsiga/protheus/bin/appserver/

# Limpando arquivos desnecessários
#rm /totvs11/microsiga/leame
#rm /totvs11/microsiga/leiame
#rm -rf /totvs11/microsiga/protheus/my\ projects
#rm -rf /totvs11/microsiga/protheus/bin/smartclient
#rm -rf /totvs11/microsiga/protheus/srvwizard
#rm -rf /totvs11/microsiga/protheus_data/samples

#mv /totvs11 /opt/totvs

cp /build/docker-entrypoint.sh /
cp /build/appserver.ini /totvs11/microsiga/protheus/bin/appserver/

#rm -rf /build
