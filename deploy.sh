#!/bin/bash

rootDir="/root/yikaaitu/"
springDir="/root/yikaaitu/spring-end"
composeFile="/root/yikaaitu/docker-compose.yml"

if [ ! -d "$rootDir" ];then
  mkdir -p $rootDir
fi

cd /root/yikaaitu

if [ ! -d "$springDir" ];then
  git clone https://github.com/PT-SIXSIXSIX/spring-end.git
fi

if [ ! -f "$composeFile" ];then
  wget -q https://raw.githubusercontent.com/PT-SIXSIXSIX/deploy/master/docker-compose.yml
fi

docker-compose up
