#!bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "add on reboot to crontable" 

croncmd="bash $DIR/onreboot.sh"
cronjob="@reboot $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -

echo "add everyday.sh to crontable" 

croncmd="bash $DIR/everyday.sh"
cronjob="20 0 * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -

echo "add everyhour.sh to crontable" 

croncmd="bash $DIR/everyhour.sh"
cronjob="20 * * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -
