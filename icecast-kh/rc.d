#!/bin/bash

. /etc/rc.conf
. /etc/rc.d/functions

case "$1" in
  start)
    stat_busy 'Starting Icecast Server'
    /usr/bin/icecast -b -c /etc/icecast.xml </dev/null &>/dev/null
    if [[  $? -gt 0 ]]; then
      stat_fail
    else
      add_daemon icecast
      stat_done
    fi
    ;;
  stop)
    stat_busy 'Stopping Icecast Server'
    rm_daemon icecast
    stat_done
    ;;
  restart)
    $0 stop
    sleep 1
    $0 start
    ;;
  *)
    echo "usage: $0 {start|stop|restart}"  
esac

# vim:set ts=2 sw=2 ft=sh et:
