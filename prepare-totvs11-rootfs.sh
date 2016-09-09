#!/usr/bin/env bash

DOWNLOAD_PATH="totvs-downloads"
TOTVS11_ROOTFS="totvs11"

# Criando estrutura básica
mkdir -p $TOTVS11_ROOTFS/microsiga/protheus/{,apo/,include/,bin/appserver/,updates/{apo/,bin/{appserver/,smartclient/},pak/,ptm/,upd/}}

# Descompactando RPMs
rpm2cpio.pl "${DOWNLOAD_PATH}/totvs11microsigaprotheus-data-11.0-1.i586.rpm" | cpio -idv -f "./totvs11/microsiga/protheus_data/samples/*" -R :nobody
chmod -R +X $TOTVS11_ROOTFS
rpm2cpio.pl "${DOWNLOAD_PATH}/totvs11microsigaprotheus-systemload-general-por-11.0-1.i586.rpm" | cpio -idv -R :nobody
chmod -R +X $TOTVS11_ROOTFS
rpm2cpio.pl "${DOWNLOAD_PATH}/totvs11microsigaprotheus-systemload-bra-11.0-1.i586.rpm" | cpio -idv -R :nobody
chmod -R +X $TOTVS11_ROOTFS

# Descompactando updates e includes
unzip -o $DOWNLOAD_PATH/15-12-01-UPDATE_BRA-EUA-PAR-URU-TTTP110.ZIP 15-11-30-update_bra-eua-par-uru-tttp110.upd -d $TOTVS11_ROOTFS/microsiga/protheus/updates/upd/
unzip -o $DOWNLOAD_PATH/15-12-02-INCLUDES_P11.ZIP -d $TOTVS11_ROOTFS/microsiga/protheus/include/
unzip -o $DOWNLOAD_PATH/15-09-08-BRA-DICIONARIOS.ZIP -d $TOTVS11_ROOTFS/microsiga/protheus_data/systemload/

cp $DOWNLOAD_PATH/15-12-01-BRA-EUA-PAR-URU-TTTP110.RPO $TOTVS11_ROOTFS/microsiga/protheus/apo/tttp110.rpo

# Appserver
unzip -o $DOWNLOAD_PATH/15-12-02-P11_APPSERVER_LINUX_X64.ZIP appserverLinux_x64/appsrvlinux_x64.tar.gz appserverLinux_x64/libctreetmp_x64.tar.gz -d $TOTVS11_ROOTFS/tmp/
tar -xvzf $TOTVS11_ROOTFS/tmp/appserverLinux_x64/appsrvlinux_x64.tar.gz -C $TOTVS11_ROOTFS/microsiga/protheus/bin/appserver/
tar -xvzf $TOTVS11_ROOTFS/tmp/appserverLinux_x64/libctreetmp_x64.tar.gz -C $TOTVS11_ROOTFS/microsiga/protheus/bin/appserver/

# Removendo temp
rm -rf $TOTVS11_ROOTFS/tmp/

# Corrigindo permissoes
find $TOTVS11_ROOTFS/microsiga/protheus_data -type d -print0 | xargs -0 chmod 0750
find $TOTVS11_ROOTFS/microsiga/protheus_data -type f -print0 | xargs -0 chmod 0644
sudo chown -R root: $TOTVS11_ROOTFS

# Criando totvs11-rootfs
COPYFILE_DISABLE=1 tar -cvz -f totvs11-rootfs.tgz $TOTVS11_ROOTFS

# Removendo pasta do rootfs
sudo rm -rf $TOTVS11_ROOTFS
