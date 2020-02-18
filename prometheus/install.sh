#!/bin/bash

set -e

prometheus_version="2.16.0"

cd /opt

wget https://github.com/prometheus/prometheus/releases/download/v$prometheus_version/prometheus-$prometheus_version.linux-armv7.tar.gz
mkdir prometheus
tar xfz prometheus-$prometheus_version.linux-armv7.tar.gz -C prometheus --strip-components 1
rm prometheus-$prometheus_version.linux-armv7.tar.gz
cd prometheus/
mv prometheus.yml prometheus-default.yml
wget https://raw.githubusercontent.com/Tony-Mc/pi/master/prometheus/prometheus.yml

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 9090 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp -m tcp -m tcp --sport 9090 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp -m tcp --dport 9101 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp -m tcp --sport 9101 -m state --state RELATED,ESTABLISHED -j ACCEPT

wget -P /etc/systemd/system/ https://raw.githubusercontent.com/Tony-Mc/pi/master/prometheus/prometheus.service

systemctl enable prometheus

systemctl start prometheus
