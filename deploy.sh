#!/bin/bash

rootDir="/root/yikaaitu/"
springDir="/root/yikaaitu/spring-end"
deployDir="/root/yikaaitu/deploy"

if [ ! -d "$rootDir" ];then
  mkdir -p $rootDir
fi

cd $rootDir

if [ ! -d "$springDir" ];then
  git clone https://github.com/PT-SIXSIXSIX/spring-end.git
fi

if [ ! -d "$deployDir" ];then
  git clone https://github.com/PT-SIXSIXSIX/deploy.git
fi

cd $deployDir

docker-compose up -d

sleep 20

docker-compose exec ykat-mysql mysql -uroot -p 123456 YKAT < YKAT.sql
