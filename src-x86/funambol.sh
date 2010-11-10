#!/bin/sh

QPKG_NAME=Funambol
FUNAMBOL_HOME=
WEB_SHARE=`/sbin/getcfg SHARE_DEF defWeb -d Qweb -f /etc/config/def_share.info`
PUBLIC_SHARE=`/sbin/getcfg SHARE_DEF defPublic -d Public -f /etc/config/def_share.info`
RETVAL=0

# checking the existence of required busybox utilities
#
[ -f /bin/expr ] || /bin/ln -sf busybox /bin/expr
[ -f /bin/kill ] || /bin/ln -sf busybox /bin/kill
[ -f /bin/sleep ] || /bin/ln -sf busybox /bin/sleep
[ -f /bin/cat ] || /bin/ln -sf busybox /bin/cat

if [ `/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f /etc/config/qpkg.conf` = UNKNOWN ]; then
        /sbin/setcfg $QPKG_NAME Enable TRUE -f /etc/config/qpkg.conf
elif [ `/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f /etc/config/qpkg.conf` != TRUE ]; then
        echo "$QPKG_NAME is disabled."
fi

_exit()
{
        /bin/echo -e "Error: $*"
        exit 1
}

# Determine BASE installation location according to smb.conf
find_base(){
	# Determine BASE installation location according to smb.conf
  QPKG_BASE=
  publicdir=`/sbin/getcfg $PUBLIC_SHARE path -f /etc/config/smb.conf`
  if [ ! -z $publicdir ] && [ -d $publicdir ];then
          publicdirp1=`/bin/echo $publicdir | /bin/cut -d "/" -f 2`
          publicdirp2=`/bin/echo $publicdir | /bin/cut -d "/" -f 3`
          publicdirp3=`/bin/echo $publicdir | /bin/cut -d "/" -f 4`
          if [ ! -z $publicdirp1 ] && [ ! -z $publicdirp2 ] && [ ! -z $publicdirp3 ]; then
                  [ -d "/${publicdirp1}/${publicdirp2}/${PUBLIC_SHARE}" ] && QPKG_BASE="/${publicdirp1}/${publicdirp2}"
          fi
  fi

  # Determine BASE installation location by checking where the Public folder is.
  if [ -z $QPKG_BASE ]; then
          for datadirtest in /share/HDA_DATA /share/HDB_DATA /share/HDC_DATA /share/HDD_DATA /share/MD0_DATA /share/MD1_DATA; do
                  [ -d $datadirtest/$PUBLIC_SHARE ] && QPKG_BASE="/${publicdirp1}/${publicdirp2}"
          done
  fi
  if [ -z $QPKG_BASE ] ; then
          echo "The Public share not found."
          _exit 1
  fi
  FUNAMBOL_HOME=$QPKG_BASE/.qpkg/$QPKG_NAME
}
find_base

#FUNAMBOL_HOME=`(cd .. ; pwd)`
DS_SERVER_HOME=$FUNAMBOL_HOME/ds-server

if [ ! -d $FUNAMBOL_HOME/config ]; then
    #
    # maybe we are in Funambol/tool/bin
    #
    FUNAMBOL_HOME=$FUNAMBOL_HOME/..
    DS_SERVER_HOME=$FUNAMBOL_HOME/ds-server
fi

# Setting the JAVA_HOME to the JRE in the bundle if not set or if not correctly set
if [ -z "$JAVA_HOME" ]; then
    export JAVA_HOME=$FUNAMBOL_HOME/tools/jre-1.5.0/jre
else
    if [ ! -f "$JAVA_HOME/bin/java" ]; then
        export JAVA_HOME=$FUNAMBOL_HOME/tools/jre-1.5.0/jre
    fi
fi

if [ -z "$JAVA_HOME" ]; then
  echo "Please, set JAVA_HOME before running this script."
  exit 1
fi

if [ ! -f "$JAVA_HOME/bin/java" ]
then
    echo "Please set JAVA_HOME to the path of a valid jre."
    exit;
fi

export J2EE_HOME=${FUNAMBOL_HOME}/tools/tomcat
export CATALINA_HOME=${FUNAMBOL_HOME}/tools/tomcat

cd ${FUNAMBOL_HOME}

export LANG=en_US.utf-8

cd ${J2EE_HOME}/bin

COMED=true

case $1 in
start)
		echo "Starting Funambol... "
    if [ "$COMED" = "true" ] ; then
        #
        # Run Hypersonic
        #
        sh $FUNAMBOL_HOME/bin/hypersonic start > /dev/null
    fi

    #
    # Run CTP Server
    #
    sh $FUNAMBOL_HOME/bin/ctp-server start > /dev/null

    #
    # Run DS Server
    #
    sh $FUNAMBOL_HOME/bin/funambol-server start > /dev/null

    #
    # Run Inbox Listener
    #
    sh $FUNAMBOL_HOME/bin/inbox-listener start > /dev/null

    #
    # Run Pim Listener
    #
    sh $FUNAMBOL_HOME/bin/pim-listener start > /dev/null
    ;;
stop)
		echo "Stopping Funambol... "
    #
    # Shutdown Inbox Listener
    #
    sh $FUNAMBOL_HOME/bin/inbox-listener stop > /dev/null

    #
    # Shutdown Pim Listener
    #
    sh $FUNAMBOL_HOME/bin/pim-listener stop > /dev/null

    #
    # Shutdown Tomcat
    #
    sh $FUNAMBOL_HOME/bin/funambol-server stop > /dev/null

    #
    # Shutdown CTP Server
    #
    sh $FUNAMBOL_HOME/bin/ctp-server stop > /dev/null

    if [ "$COMED" = "true" ] ; then
        #
        # Shutdown Hypersonic
        #
        sh $FUNAMBOL_HOME/bin/hypersonic stop > /dev/null
    fi
    ;;
license)
    less "${FUNAMBOL_HOME}/LICENSE.txt"
    ;;
*)
    echo "usage: $0 [start|stop|license]"
    ;;
esac

