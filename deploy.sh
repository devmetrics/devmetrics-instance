#!/bin/bash

#Update Sources configuration

git pull


echo
echo "Sources has been updated from git:https://vladimir_devmetrics@bitbucket.org/devmetrics/service.git"
echo " if there are no repository, clone it: git clone https://vladimir_devmetrics@bitbucket.org/devmetrics/service.git "

#Update Logstash configuration
sudo cp ./logstash/logstash.apps.conf /etc/logstash/conf.d/
sudo cp ./logstash/template.apps.json /etc/logstash/template.apps.json
echo
echo "Logstash configuration has been copied if need restart: sudo service logstash restart"
echo
#Update NGINX configuration 
sudo cp ./nginx/kibana4 /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/kibana4 /etc/nginx/sites-enabled/
echo
echo "NGINX configuration has been copied if need restart: sudo service nginx restart"
echo

echo "You need restart services to apply changes"
echo
read -p "Would you like restart logstash and nginx services yes/No? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo service logstash restart
    sudo service nginx restart
fi

echo "update cron tasks"
bash ./cron/create_cron_task.sh 

