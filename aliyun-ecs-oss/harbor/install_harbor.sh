#!/usr/bin/env bash

set -e

# Locate shell script path
SCRIPT_DIR=$(dirname $0)
if [ ${SCRIPT_DIR} != '.' ]
then
  cd ${SCRIPT_DIR}
fi



cd /downloads/packages/harbor
tar xvf harbor-offline-installer-*.tgz
mv harbor /opt

cd /opt/harbor

HOST_NAME=$(../../components/utils/get_ip.sh)
../../components/utils/replace_in_file.sh /opt/harbor/harbor.cfg "hostname = reg.mydomain.com" "hostname = ${HOST_NAME}"

sudo ./install.sh

echo "Harbor URL: http://${HOST_NAME}"
