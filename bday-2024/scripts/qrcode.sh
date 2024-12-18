#!/bin/bash
#set -v # do not expand variables
set -x # output
set -e # stop on error
set -u # stop if you use an uninitialized variable

# Script directory
SCRIPTDIR=`dirname $0`
cd $SCRIPTDIR
SCRIPTDIR=`pwd`
cd -
echo $SCRIPTDIR

elements="fuoco acqua terra aria"

for PACKAGE in $PACKAGES
do
    docker pull docker-registry.hyperborea.com/stimare/$PACKAGE:$VERSION
    docker save docker-registry.hyperborea.com/stimare/$PACKAGE:$VERSION | gzip > $PACKAGE.$VERSION.tgz
done
