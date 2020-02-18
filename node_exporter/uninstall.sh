systemctl stop node_exporter
systemctl disable node_exporter
rm /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl reset-failed
rm /opt/node_exporter
