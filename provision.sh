#!/bin/bash

zone="America/La_Paz"

export DEBIAN_FRONTEND=noninteractive

apt install -y curl ntpdate 2>/dev/null | grep packages | cut -d '.' -f 1

curl -fsSL https://get.docker.com | sh

usermod -aG docker vagrant

sed -i "s/^ExecStart=.*/ExecStart=\/usr\/bin\/dockerd -H unix:\/\/ -H tcp:\/\/0.0.0.0:2375 --experimental=true --debug=true --metrics-addr=\"0.0.0.0:9323\" --containerd=\/run\/containerd\/containerd.sock/g" /lib/systemd/system/docker.service

chmod 666 /var/run/docker.sock

ntpdate ntp.ubuntu.com

sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/$zone /etc/localtime

systemctl daemon-reload && systemctl restart docker
