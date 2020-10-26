#!/bin/sh
set -e

# TODO fix --yes

apt-get update

apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update

apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

docker --version