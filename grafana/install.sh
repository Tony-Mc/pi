#!/bin/bash

set -e

grafana_version="6.6.1"

cd /opt

apt-get install -y adduser libfontconfig1
wget "https://dl.grafana.com/oss/release/grafana_${grafana_version}_arm64.deb"
dpkg -i "grafana_${grafana_version}_arm64.deb"
rm "grafana_${grafana_version}_arm64.deb"

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3000 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp -m tcp -m tcp --sport 3000 -m state --state RELATED,ESTABLISHED -j ACCEPT

systemctl enable grafana-server

systemctl start grafana-server

systemctl status grafana-server
