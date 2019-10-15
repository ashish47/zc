#!/bin/bash

sudo apt update

#install node
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt install -y nodejs

echo "Node installed and setup"
# install mosquitto MQTT broker
sudo apt-get install mosquitto -y
echo "Mosquitto installed"
#install mongodb and configure the same
sudo apt-get install mongodb -y
echo "MongoDB installed"
#Host as an access point
sudo apt-get install dnsmasq hostapd -y

# win NET BIOS
sudo apt-get install samba -y
sudo apt-get install winbind -y

# install remot3.it
sudo apt install connectd -y

# install nginx
sudo apt-get install nginx -y
