#!/bin/bash
export HOSTNAME=`curl http://169.254.169.254/latest/meta-data/public-hostname`
export SHORT_HOSTNAME=`echo ${HOSTNAME%%.*}`

globus-connect-server-setup
echo "All done... Server running"
sleep infinity &
wait
