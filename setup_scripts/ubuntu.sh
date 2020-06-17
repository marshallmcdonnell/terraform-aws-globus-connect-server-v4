#!/bin/bash
sudo curl -LOs https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo_latest_all.deb
sudo dpkg -i globus-connect-server-repo_latest_all.deb
sudo apt-get update
sudo apt-get install \
    globus-connect-server \
    globus-connect-server-io \
    globus-connect-server-web \
    globus-connect-server-id
source .env
sudo mv globus-connect-server.conf /etc/globus-connect-server.conf
export HOSTNAME=`curl http://169.254.169.254/latest/meta-data/public-hostname`
export SHORT_HOSTNAME=`echo ${PUBLIC_HOSTNAME%%.*}`
export DOMAIN_NAME=`echo ${PUBLIC_HOSTNAME#*.}`
sudo globus-connect-server-setup
