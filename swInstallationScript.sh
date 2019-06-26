#!/bin/bash
git clone https://github.com/rajeshmanapat/Voyager-Zone-Controller.git --branch trackerID_removal --single-branch
git clone https://github.com/gitofanarghya/ZC-UI


#install node
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt install -y nodejs

# add UI dependencies
cd /home/pi/ZC-UI/
npm install express
npm install socketio
npm install mqtt
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
