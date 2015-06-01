#!bin/bash

# backup "app-*"indices
# [TODO]


# retention policy for our "app-*" indices 7 day
sudo curator --logfile /opt/log/curator/curator.log --loglevel INFO delete indices --older-than 7 --time-unit days --timestring '%Y.%m.%d' --prefix app-
