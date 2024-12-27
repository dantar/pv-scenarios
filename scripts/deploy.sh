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

GAME=sogno

DEST=atlante.elabor.biz:dist/
DEST=dantar:html/
die() { echo "$*" 1>&2 ; exit 1; }
while getopts h:g: flag;
do
    echo "FLAG ${flag}"
    case "${flag}" in
        h) case "${OPTARG}" in
                atlante) 
                    TARGET=${OPTARG}
                    DEST=atlante.elabor.biz:dist/
                ;;
                dantar) 
                    TARGET=${OPTARG}
                    DEST=dantar:html/
                ;;
                *) die "opzione invalida: ${OPTARG}";;
            esac
        ;;
        g) GAME=${OPTARG}
        if [ -d $MAINDIR/$GAME ]; then
            echo "Game: ${GAME}"
        else
            die "ERROR: Game ${GAME} does not exist!"
        fi
        ;;
        *) die "opzione invalida: ${flag}";;
    esac
done

cd $MAINDIR
rsync --delete -varzh $MAINDIR/$GAME $DEST