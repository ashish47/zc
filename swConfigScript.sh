#To enable xbee communication 
sudo sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt

#Crontab editions
crontab -l > mycron
#echo new cron into cron file
echo "00 00 * * * /home/pi/Voyager-Zone-Controller/misc/ntpPull" >> mycron
echo "@reboot /home/pi/Voyager-Zone-Controller/misc/pullTimeFromHwClockIfNoNet" >> mycron
#install new cron file
crontab mycron
rm mycron


#copy config file
sudo cp /home/pi/Voyager-Zone-Controller/misc/config.txt /boot/config.txt

# Change default password to sunshine
echo -e "raspberry\nsunshine\nsunshine\n" | passwd



#!/bin/bash
# Clock configuration
sudo systemctl stop fake-hwclock.service
sudo systemctl disable fake-hwclock.service
sudo systemctl stop systemd-timesyncd.service
sudo cp /home/pi/Voyager-Zone-Controller/misc/hwclock-set /lib/udev/hwclock-set
echo "Clock configuration Done"
# GPIO daemon
sudo pigpiod


sudo mkdir /data
sudo mkdir /data/db
sudo cp /home/pi/Voyager-Zone-Controller/misc/mongodb-server /etc/logrotate.d/mongodb-server


sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo service dhcpcd restart
sleep 5


#Editing configuration files for access point creation
mac_id=$(cat /sys/class/net/wlan0/address)
echo -e "\ninterface wlan1\n    static ip_address=192.168.4.1/24\n    nohook wpa_supplicant" | sudo tee -a /etc/dhcpcd.conf
echo -e "interface=wlan1\n    dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,96000h" | sudo tee -a /etc/dnsmasq.conf
echo -e "interface=wlan1\ndriver=nl80211\nhw_mode=g\nchannel=7\nwmm_enabled=0\nmacaddr_acl=0\nauth_algs=1\nignore_broadcast_ssid=0\nwpa=2\nssid=VZC_$mac_id\nwpa_passphrase=sunshine\nwpa_key_mgmt=WPA-PSK\nwpa_pairwise=TKIP\nrsn_pairwise=CCMP" | sudo tee -a /etc/hostapd/hostapd.conf
echo -e "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" | sudo tee -a /etc/default/hostapd
echo -e "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo systemctl unmask hostapd
sudo systemctl start hostapd
sudo systemctl start dnsmasq
sleep 5
sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sleep 2
#Start hotspot on boot
sudo update-rc.d hostapd enable
sudo update-rc.d dnsmasq enable
sleep 3
echo "Accesspoint Setup done"

# Resore default settings to DB
mongorestore /home/pi/Voyager-Zone-Controller/dump

#Give execute permissions to services installation script 
sudo chmod +744 /home/pi/Voyager-Zone-Controller/misc/installServices.sh

# Install services
/home/pi/Voyager-Zone-Controller/misc/installServices.sh


# set time to hardware clock
sudo hwclock -w

sudo cp /home/pi/Voyager-Zone-Controller/misc/nsswitch.conf /etc/nsswitch.conf

sudo reboot