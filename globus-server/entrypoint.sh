#!/bin/bash
export SHORT_HOSTNAME=`echo ${PUBLIC_HOSTNAME%%.*}`
echo "\n\nPUBLIC_HOSTNAME" $PUBLIC_HOSTNAME >> "docker.log"
echo "\n\nSHORT_HOSTNAME" $SHORT_HOSTNAME >> "docker.log"

echo "Creating activation user"
useradd -ms /bin/bash "${ACTIVATION_USER}"
chown "${ACTIVATION_USER}" /data
echo ""${ACTIVATION_USER}":"${ACTIVATION_PASSWORD}"" | chpasswd

globus-connect-server-setup
echo "All done... Server running"
sleep infinity &
wait
