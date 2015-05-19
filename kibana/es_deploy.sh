#!/bin/bash
if [ $# -lt 4 ] 
	then 
 		echo 'script has 3 parameters: server="localhost:9200", index =".kibana", pattern="logstash-*", location="\/"'
 		exit 1
fi

server=$1
index=$2
pattern=$3
location=$4

if false; then
	echo "ttttt"
fi

run_curl ()
{
  lstr=$1
  lfile=$2
#  echo "$lstr"
  myout=$(eval "$lstr")

	  status=$?
	  if [ $status -ne 0 ]; then 
	  	 echo "curl failed with error code: $status  at:"
	  	 echo "$lstr"
	  	 exit 1
	  fi	 
      #extract _id from query result  
	  id=$(echo $myout | sed -n 's/^.*_id":"\([^"]*\)\(.*\)/\1/p')
	  #echo $id

	  if [ "" == "$id" ];
	  	   then
	  		echo "Error loading file:" "$lfile"
	  		echo "Request:" "$lstr" 
	  		echo "Server Response:" "$myout"
	  		exit 1
	  fi		
	echo "File: \""$lfile"\" uploaded successfully"  

}

# Create/Update index_pattern, requires that index for this pattern exists.  
cd "index-pattern"
      
      d="index-pattern.json"
	  jsonstr="$(tr -d '\n' < "index-pattern.json" | sed 's/\$\$pattern\$\$/'${pattern}'/g' )"
	  runstr="curl -XPUT "$server/$index"/index-pattern/"$pattern" -d '"$jsonstr"'"

      run_curl "$runstr" "$d"

cd ..


for dir in "visualization" "search" "dashboard"; do

	cd $dir
 	for d in *; do
	  filename=${d%.*}
      # replace pattern and templete strings by parameters
	  jsonstr="$(tr -d '\n' < $d | sed 's/\$\$location\$\$/'${location}'/g;s/\$\$pattern\$\$/'${pattern}'/g')"
	  runstr="curl -XPUT "$server"/"$index"/"$dir"/"$filename" -d '"$jsonstr"'"

      run_curl "$runstr" "$d"
	done

	cd ..
done

#Setting index_pattern as default 

     runstr=($"curl -XPOST "$server/$index"/config/4.0.2 -d '{\"buildNum\":6004}'")
     
     run_curl "$runstr" "set configuration"
      


      runstr=($"curl -XPOST "$server/$index"/config/4.0.2/_update -d '
     {
	    doc:{buildNum: 6004, defaultIndex: \""$pattern"\", \"format:numberPrecision\": \"0\"}
     }'")
     run_curl "$runstr" "set default pattern"

