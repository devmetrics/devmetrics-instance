# devmetrics-instance
Backend for devmetrics monitoring solution. Repository contains monitoring dashboards and configuration of backend.

# Precondition
Installation requires pre-configured AWS Image "Devmetrics Instance v0.4" AMI ID: ami-2d769746 

# Installation
1. Launch t2.small AWS instance from image ami-2d769746
2. Open follow ports on the instance: tcp 22, 80, 443; tcp/udp 5545
3. Connect to instance by ssh
4. Run follow commands on instance:
    git clone https://github.com/devmetrics/devmetrics-instance.git
    cd devmetrics-instance
    bash deploy.sh
    bash kibana_deploy.sh devmetrics
    bash user_generate.sh dm_user
5. Save password for access instance  

# HTTPS support
1. Copy certificate and primary key to folder devmetrics-instance/cert
2. Replace nginx configuration: 
    sudo rm /etc/nginx/sites-enabled/kibana4
    sudo cp ~/instance/nginx/kibana4-ssl /etc/nginx/sites-available/
    sudo ln -s /etc/nginx/sites-available/kibana4-ssl /etc/nginx/sites-enabled/
    sudo service nginx restart
