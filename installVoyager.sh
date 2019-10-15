#!/bin/bash
git clone https://github.com/astralpresence/voyagerRelease --branch $1 --single-branch Voyager-Zone-Controller

# add UI dependencies
cd /home/pi/Voyager-Zone-Controller/ui/
npm install express
npm install socketio
npm install mqtt


#replace default rc.local file with our rc.local file
sudo cp /home/pi/Voyager-Zone-Controller/misc/rc.local /etc/rc.local

#For UI to host at zc.ftcsolar.com change dnsmasq and host config 
sudo cp /home/pi/Voyager-Zone-Controller/Networking/dnsmasq.conf /etc/dnsmasq.conf
echo -e "192.168.4.1\tzc" |sudo tee -a /etc/hosts

#To enable xbee communication 
sudo sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt

#Crontab editions
sudo systemctl enable cron.service
sudo crontab -l > mycron
#echo new cron into cron file
echo "00 00 * * * /home/pi/Voyager-Zone-Controller/misc/ntpPull" >> mycron
echo "@reboot /home/pi/Voyager-Zone-Controller/misc/pullTimeFromHwClockIfNoNet" >> mycron
echo "00 00 * * * /home/pi/Voyager-Zone-Controller/dist/setRoverTime" >> mycron


#install new cron file
sudo crontab mycron
rm mycron


#copy config file
sudo cp /home/pi/Voyager-Zone-Controller/misc/config.txt /boot/config.txt

#copy dns config file
sudo cp /home/pi/Voyager-Zone-Controller/misc/resolv.conf /etc/resolv.conf

# Change default password to sunshine
echo -e "raspberry\nsunshine\nsunshine\n" | passwd



#!/bin/bash
# Clock configuration
sudo systemctl stop fake-hwclock.service
sudo systemctl disable fake-hwclock.service
sudo systemctl stop systemd-timesyncd.service
sudo cp /home/pi/Voyager-Zone-Controller/misc/hwclock-set /lib/udev/hwclock-set
echo "Clock configuration Done"


sudo mkdir /data
sudo mkdir /data/db
sudo cp /home/pi/Voyager-Zone-Controller/misc/mongodb-server /etc/logrotate.d/mongodb-server


sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
sudo service dhcpcd restart


#Editing configuration files for access point creation
echo -e "\ninterface wlan1\n    static ip_address=192.168.4.1/24\n    nohook wpa_supplicant" | sudo tee -a /etc/dhcpcd.conf
echo -e "interface=wlan1\n    dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,96000h" | sudo tee -a /etc/dnsmasq.conf
echo -e "interface=wlan1\ndriver=nl80211\nhw_mode=g\nchannel=7\nwmm_enabled=0\nmacaddr_acl=0\nauth_algs=1\nignore_broadcast_ssid=0\nwpa=2\nssid=Voyager_default_zoneID\nwpa_passphrase=sunshine\nwpa_key_mgmt=WPA-PSK\nwpa_pairwise=TKIP\nrsn_pairwise=CCMP" | sudo tee -a /etc/hostapd/hostapd.conf
echo -e "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" | sudo tee -a /etc/default/hostapd
echo -e "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo systemctl unmask hostapd
sudo systemctl start hostapd
sudo systemctl start dnsmasq

sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

#Start hotspot on boot
sudo update-rc.d hostapd enable
sudo update-rc.d dnsmasq enable

echo "Accesspoint Setup done"



#Give execute permissions to services installation script 
sudo chmod +744 /home/pi/Voyager-Zone-Controller/misc/installServices.sh

# Install services
/home/pi/Voyager-Zone-Controller/misc/installServices.sh

#nginx configuration
sudo rm /etc/nginx/nginx.conf
sudo cp /home/pi/Voyager-Zone-Controller/misc/nginx.conf /etc/nginx/nginx.conf
sudo cp /home/pi/Voyager-Zone-Controller/misc/zcEngine /etc/nginx/sites-available/
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/zcEngine /etc/nginx/sites-enabled/zcEngine
sudo update-rc.d nginx enable
sudo systemctl stop nginx
sudo systemctl enable nginx 
sudo systemctl start nginx

# set time to hardware clock
sudo hwclock -w

sudo cp /home/pi/Voyager-Zone-Controller/misc/nsswitch.conf /etc/nsswitch.conf

#Switch off power management feature
sudo iw wlan1 set power_save off

#set timezone to UTC
sudo timedatectl set-timezone UTC


sudo reboot
