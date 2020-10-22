#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export IPVM=$(/sbin/ifconfig ens3 | grep -i mask | awk '{print $2}')
vm=$(hostname)
list_of_containers=$(sudo docker ps -a | awk '{if(NR>1) print $NF}')
containers=`docker ps -f status=running --format "{{.Names}}"`
for i in $list_of_containers
do
  if echo $containers |grep  $i
    then  echo "$i online "
    else curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "YOUR_CHAT_ID", "text": "'"container $i on $vm($IPVM) exited"'", "disable_notification": true}'  https://api.telegram.org/botYOUR_TOKEN/sendMessage > /dev/null
  fi 
    
done

exit 0
