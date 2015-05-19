#!/bin/bash


app_id=$1
server="ehost"

echo "Start provisioning for private instance for:"$app_id 

cd ./kibana

# create index and send message to logstash
bash send_message.sh $server $app_id "index-message.json"
status=$?
if [ $status -ne 0 ]; then 
	exit 1
fi

# deploy dashboard 
bash es_deploy.sh $server":9200" ".kibana" "app-"$app_id"*" "\/"
status=$?
if [ $status -ne 0 ]; then 
	exit 1
fi

echo "Components is installed"
exit 0
