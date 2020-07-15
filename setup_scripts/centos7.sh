#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

export GLOBUS_USER=$1
export GLOBUS_PASSWORD=$2
export ACTIVATION_USER=$3
export ACTIVATION_PASSWORD=$4


curl -LOs https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install epel-release-latest-7.noarch.rpm

curl -LOs https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm
rpm --import https://downloads.globus.org/toolkit/gt6/stable/repo/rpm/RPM-GPG-KEY-Globus
yum -y install globus-connect-server-repo-latest.noarch.rpm
yum -y install globus-connect-server

export HOSTNAME=`curl http://169.254.169.254/latest/meta-data/public-hostname`
export SHORT_HOSTNAME=`echo ${PUBLIC_HOSTNAME%%.*}`
export $GLOBUS_USER
export $GLOBUS_PASSWORD

echo "Creating activation user"
useradd -ms /bin/bash "${ACTIVATION_USER}"
chown "${ACTIVATION_USER}" /data
echo ""${ACTIVATION_USER}":"${ACTIVATION_PASSWORD}"" | chpasswd

globus-connect-server-setup

