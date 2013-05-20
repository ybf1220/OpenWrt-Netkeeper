#!/bin/sh
# give the route a domain use dnspod api 
IP=`ifconfig|grep -E '(inet addr)'|grep -v -E '(127.0.0.1|192.168.1.1)'|cut -d':' -f2 |awk '{print $1}'`
IP_Count=`ifconfig|grep -E '(inet addr)'|grep -v -E '(127.0.0.1|192.168.1.1)'|cut -d':' -f2 |awk '{print $1}'|wc -l`
login_email=""
login_password=""
format="xml"
lang="en"
ybfor_com=1150432  # ybfor.com's domain_id
sswn_net=1636528   # sswn.net's domain_id
record_id=23012816 # router.sswn.net
sub_domain=router
user_agent="robin-openwrt client /0.3($login_email)"
common_post="login_email=$login_email&login_password=$login_password&format=$format&lang=$lang"
record_modify_post="domain_id=$sswn_net&record_id=$record_id&value=$IP&record_type=A&record_line=默认"
record_list="domain_id=$sswn_net&sub_domain=$sub_domain"
if [ "$IP_Count" != "1" ]; then
exit 1
else
# curl -k -X POST -A "$user_Agent" https://dnsapi.cn/Record.List -d "$common_post&$record_list"
# wget --user-agent="$user_agent" --post-data="$common_post$record_list" http://dnsapi.cn/Record.List
curl -k -X POST -A "$user_agent" https://dnsapi.cn/Record.Modify  -d "$common_post&$record_modify_post&sub_domain=$sub_domain" > /root/domain.log 
# curl -k -X POST -A "$user_agent" https://dnsapi.cn/Record.Ddns  -d "$common_post&$record_modify_post&sub_domain=$sub_domain" > /root/domain.log 
fi
exit 0
