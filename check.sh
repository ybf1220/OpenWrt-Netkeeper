#!/bin/sh
IP=`ifconfig |grep 'inet addr'|grep -v -E '(127.0.0.1|192.168.1.1)'|cut -d: -f2|awk '{print $1}'`

IP_COUNT=`ifconfig |grep 'inet addr'|grep -v -E '(127.0.0.1|192.168.1.1)'|cut -d: -f2|awk '{print $1}'|wc -l`

TIME=`/bin/date "+%m-%d %A %H:%M:%S"`

PPP_PID=`ps |grep 'pppd'|grep -v 'grep' |cut -d' ' -f2-3`

if [ "$IP_COUNT" == "1" ]; then
echo "Currently Time is $TIME, IP is $IP, PID is $PPP_PID" >> /root/shanxun_0.log
exit 0
else
echo "Currently Time is $TIME, sx is not ready, restart network !!" >> /root/shanxun_1.log 
/etc/init.d/network restart
fi
 
