#!/bin/bash
if [ $# -lt 3 ] 
	then 
 		echo 'script has 2 parameters: server="localhost", appid ="devmetrics", message="index-message.json" '
 		exit 1
fi

server=$1
appid=$2
messagefile=$3


cd "index-message"
      
      jsonstr="$(tr -d '\n' < ${messagefile} | sed 's/\$\$appid\$\$/'${appid}'/g' )"
	  echo $jsonstr | nc $server 5545
      status=$?
	  if [ $status -ne 0 ]; then 
	  	 echo "nc failed with error code: $status. Check address"
	  	 echo "message: " $jsonstr
	  	 exit 1
	  fi	 


cd ..

