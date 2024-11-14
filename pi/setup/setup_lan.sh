#!/bin/bash
sudo bash -c 'cat >> /etc/dhcpcd.conf << EOF
interface eth0
static ip_address=192.168.1.100/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
EOF'

sudo service dhcpcd restart
echo "LAN setup complete with static IP: 192.168.1.100"

