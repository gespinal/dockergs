#!/bin/bash

ip_address=$1
host_name=$2

match="$(grep -n $host_name /etc/hosts | cut -f1 -d:)"
host_entry="${ip_address} ${host_name}"

if [ $match ]; then
  echo "Updating existing hosts entry."
  #sudo sed -i '' "/$host_name/d'" hosts
  sudo sed -i '' "${match}s/.*/${host_entry}/" /etc/hosts
else
  echo "Adding new hosts entry."
  #echo $host_entry | sudo tee -a /etc/hosts > /dev/null
  echo $host_entry | sudo tee -a /etc/hosts > /dev/null
fi
