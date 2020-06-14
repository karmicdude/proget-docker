#!/usr/bin/env bash
set -eo pipefail

# Set default variables
: "${PROGET_DB_TYPE:=SqlServer}"
: "${PROGET_DB_HOST:=proget-db}"
: "${PROGET_DB_NAME:=ProGet}"
: "${PROGET_DB_USER:=sa}"
: "${PROGET_DB_PASS:=YourStrong!Passw0rd}"
: "${PROGET_SVC_MODE:=both}"

cat << EOF
++++++++++++++++++
++ Summary info ++
++++++++++++++++++

VARIABLES:
    PROGET_DB_TYPE: ${PROGET_DB_TYPE}
    PROGET_DB_HOST: ${PROGET_DB_HOST}
    PROGET_DB_NAME: ${PROGET_DB_NAME}
    PROGET_DB_USER: ${PROGET_DB_USER}
    PROGET_DB_PASS: ${PROGET_DB_PASS}
    PROGET_SVC_MODE: ${PROGET_SVC_MODE}

++++++++++++++++++++

EOF

echo "-> Generate 'ProGet.config'"
cat << EOF > /usr/share/Inedo/SharedConfig/ProGet.config
<?xml version="1.0" encoding="utf-8"?>
<InedoAppConfig>
  <ConnectionString>Data Source=${PROGET_DB_HOST};Initial Catalog=${PROGET_DB_NAME};User Id=${PROGET_DB_USER};Password=${PROGET_DB_PASS};</ConnectionString>
  <EncryptionKey>71d711d7b2457c4a0d4a94d4d54db5e7</EncryptionKey>
  <WebServer Enabled="true" Urls="http://*:80/" />
</InedoAppConfig>
EOF

if [ "$1" = "start" ]; then
  echo
  echo "+++++++++++++++++++++++++++"
  echo "++ RUNNING ProGet Server ++"
  echo "+++++++++++++++++++++++++++"
  echo
  sleep 2
  exec mono /usr/local/proget/service/ProGet.Service.exe run --mode=$PROGET_SVC_MODE --linuxContainer
fi

exec "$@"
