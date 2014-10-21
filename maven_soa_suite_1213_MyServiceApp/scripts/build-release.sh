#!/bin/sh
set -eu
: ${GO_PIPELINE_COUNTER:?}
: ${PWD:?}
set -x

RELEASE_VERSION=`ruby scripts/get-maven-release-version.rb $GO_PIPELINE_COUNTER`
TAG="v$RELEASE_VERSION"

mkdir artifacts

echo "${RELEASE_VERSION}" > artifacts/version
echo "${TAG}" > artifacts/tag

mvn versions:set \
    --batch-mode \
    --errors \
    -DgenerateBackupPoms=false \
    -DnewVersion="$RELEASE_VERSION" \
    --file pom.xml
