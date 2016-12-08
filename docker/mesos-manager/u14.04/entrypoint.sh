#!/usr/bin/env bash
set -x
source /common.sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/bin/supervisord
CONFIG=/etc/contrail/contrail-kubernetes.conf
SERVICE=kubernetes
ANSIBLE_INVENTORY=${ANSIBLE_INVENTORY:-"all-in-one"}

test -x $DAEMON || exit 0

DAEMON_OPTS="-n -c /etc/contrail/supervisord_${SERVICE}.conf $DAEMON_OPTS"
ulimit -s unlimited
ulimit -c unlimited
ulimit -d unlimited
ulimit -v unlimited
ulimit -n 4096
RUN contrailctl config sync -c mesosmanager -F -t configure,provision
$DAEMON $DAEMON_OPTS
