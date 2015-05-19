#!/bin/bash

#Generate Password

user=$1
password=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

sudo htpasswd -b /etc/nginx/htpasswd.users $user $password

echo $user":"$password
