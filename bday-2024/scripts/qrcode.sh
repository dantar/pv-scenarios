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

CODE=$1
qrencode -o $SCRIPTDIR/../resources/qrcodes/$CODE.png https://dantar.it/ponte-virtuale/#/play/bday-2024/$CODE

