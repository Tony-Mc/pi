systemctl stop node_exporter
systemctl disable node_exporter
rm /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl reset-failed
rm -rf /opt/node_exporter

iptables -D INPUT -i eth0 -p tcp -m tcp --dport 9100 -j ACCEPT
iptables -D OUTPUT -o eth0 -p tcp -m tcp -m tcp --sport 9100 -m state --state RELATED,ESTABLISHED -j ACCEPT