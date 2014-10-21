#!/bin/sh
set -eu
: ${DEPLOY_USERNAME:?}
: ${DEPLOY_PASSWORD:?}
set -x

VERSION=`cat artifacts/version`

curl \
  --silent --fail --show-error \
  --basic --user "$DEPLOY_USERNAME:$DEPLOY_PASSWORD" \
  --form r=releases \
  --form hasPom=false \
  --form g=oracle.demo \
  --form a=myservice \
  --form v="$VERSION" \
  --form e=jar \
  --form p=jar \
  --form file="@artifacts/sca_myservice_rev$VERSION.jar" \
  http://localhost:8081/nexus/service/local/artifact/maven/content
