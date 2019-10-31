#!/bin/bash

if [ "${TRAVIS_PULL_REQUEST}" != "false" ];then
  exit
fi

docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

VERSION=$(docker run --rm -it nnm:latest /opt/nnm/bin/nnm -v | awk '/NNM/{print $2}')

MAJOR=$(echo ${VERSION} | cut -d '.' -f 1)
MINOR=$(echo ${VERSION} | cut -d '.' -f 2)
PATCH=$(echo ${VERSION} | cut -d '.' -f 3)

echo "Discovered Nessus Version ${VERSION} = ${MAJOR}.${MINOR}.${PATCH}"

docker tag nessus_scanner:latest ${RPRE}/${RNAME}:${MAJOR}
docker tag nessus_scanner:latest ${RPRE}/${RNAME}:${MAJOR}.${MINOR}
docker tag nessus_scanner:latest ${RPRE}/${RNAME}:${MAJOR}.${MINOR}.${PATCH}
docker tag nessus_scanner:latest ${RPRE}/${RNAME}:latest

echo "Images to be pushed: "                      \
  "${RPRE}/${RNAME}:${MAJOR}, "                   \
  "${RPRE}/${RNAME}:${MAJOR}.${MINOR}, "          \
  "${RPRE}/${RNAME}:${MAJOR}.${MINOR}.${PATCH}, " \
  "${RPRE}/${RNAME}:latest"


docker push ${RPRE}/${RNAME}:${MAJOR}
docker push ${RPRE}/${RNAME}:${MAJOR}.${MINOR}
docker push ${RPRE}/${RNAME}:${MAJOR}.${MINOR}.${PATCH}
docker push ${RPRE}/${RNAME}:latest