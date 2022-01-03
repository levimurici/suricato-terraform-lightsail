#!/bin/bash

sudo apt-get update
sudo apt-get install -y apt-transport-https \
       ca-certificates \
       curl \
       software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
docker --version
sleep 3;

sudo apt-get install -y python3 python3-pip;
sudo apt install -y docker-compose;
sleep 2;

sudo usermod -aG docker `echo $USER`;
sudo apt install acl;
sudo setfacl -m user:`echo $USER`:rw /var/run/docker.sock
sleep 2;

sudo mkdir /home/ubuntu/supreme-suricato && cd /home/ubuntu/supreme-suricato
sudo git clone https://github.com/levimurici/suricato-iot && cd suricato-iot;
sudo docker-compose up -d;