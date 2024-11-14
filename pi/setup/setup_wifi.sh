#!/bin/bash
sudo apt-get update
sudo apt-get install -y hostapd dnsmasq
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

# Hostapd configuration
sudo bash -c 'cat > /etc/hostapd/hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=PiCloudBackup
hw_mode=g
channel=6
wpa=2
wpa_passphrase=$WIFI_PASS
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
EOF'

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd

# Dnsmasq configuration
sudo bash -c 'cat > /etc/dnsmasq.conf << EOF
interface=wlan0
dhcp-range=192.168.50.10,192.168.50.50,255.255.255.0,24h
EOF'

sudo systemctl restart dnsmasq
echo "Wi-Fi Hotspot configured successfully."

