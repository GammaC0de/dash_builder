#!/bin/bash

export LC_ALL=C
export LANG=en_US.UTF-8
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale
locale-gen 
dpkg-reconfigure locales
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
apt-get install -y sl
apt-get autoremove -y
useradd -m pi
echo pi:opendsh | chpasswd
sudo adduser pi sudo
# Setup ntp
apt-get  install -y ntp ntpdate
service ntp stop
ntpdate 0.uk.pool.ntp.org
service ntp start
# Disable boot text
echo -n "logo.nologo loglevel=3 quiet plymouth.ignore-serial-consoles fastboot systemd.run=/boot/firstrun.sh systemd.run_success_action=reboot systemd.unit=kernel-command-line.target" >>  /boot/cmdline.txt
