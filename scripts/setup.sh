#!/bin/bash
#set -v # do not expand variables
set -x # output
set -e # stop on error
set -u # stop if you use an uninitialized variable

SCRIPTDIR=`dirname $0`
cd $SCRIPTDIR
SCRIPTDIR=`pwd`
MAINDIR=`dirname $SCRIPTDIR`
cd -

GAMEDIR=arezzo
DESTINATION=/var/www/html

die() { echo "$*" 1>&2 ; exit 1; }
while getopts g:l flag;
do
    case "${flag}" in
        g) GAMEDIR=${OPTARG}
            if [ ! -d ~/hack/github/pv-scenarios/$GAMEDIR ]; then
                die "Directory ${OPTARG} does not exist"
            fi
        ;;
        l) DESTINATION=${OPTARG}
        ;;
        *) die "opzione invalida: ${flag}";;
    esac
done

sudo mount --bind ~/hack/github/pv-scenarios/$GAMEDIR ${DESTINATION}/$GAMEDIR