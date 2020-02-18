#!/bin/bash

set -e

exporter_version="0.18.1"

cd /opt

wget https://github.com/prometheus/node_exporter/releases/download/v$exporter_version/node_exporter-$exporter_version.linux-armv7.tar.gz
mkdir node_exporter
tar xfz node_exporter-$exporter_version.linux-armv7.tar.gz -C node_exporter --strip-components 1
rm node_exporter-$exporter_version.linux-armv7.tar.gz
cd node_exporter/

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 9100 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp -m tcp -m tcp --sport 9100 -m state --state RELATED,ESTABLISHED -j ACCEPT

wget -P /etc/systemd/system/ https://raw.githubusercontent.com/Tony-Mc/pi/master/node_exporter/node_exporter.service

systemctl enable node_exporter

systemctl start node_exporter

systemctl status node_exporter
