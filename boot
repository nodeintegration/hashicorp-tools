#!/usr/bin/env sh

cat << EOF
export HASHICORP_HELPER_LAUNCH_TAG=\$(docker ps -a --filter 'id=${HOSTNAME}' --format {{.Image}} |cut -f 2 -d :)
echo Binding to tag: \${HASHICORP_HELPER_LAUNCH_TAG}
EOF
cat bootstrap
