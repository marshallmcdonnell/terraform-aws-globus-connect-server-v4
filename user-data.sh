#!/bin/bash
  
# Install Docker-CE
curl -SsL https://get.docker.com | bash

# Fix for not needing `sudo docker...`
sudo groupadd docker
sudo usermod -aG docker ${username}
sudo newgrp docker
sudo systemctl enable docker

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
