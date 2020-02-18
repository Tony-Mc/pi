systemctl stop prometheus
systemctl disable prometheus
rm /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl reset-failed
rm /opt/prometheus

iptables -D INPUT -i eth0 -p tcp -m tcp --dport 9090 -j ACCEPT
iptables -D OUTPUT -o eth0 -p tcp -m tcp -m tcp --sport 9090 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -D OUTPUT -o eth0 -p tcp -m tcp --dport 9101 -j ACCEPT
iptables -D INPUT -i eth0 -p tcp -m tcp -m tcp --sport 9101 -m state --state RELATED,ESTABLISHED -j ACCEPT
