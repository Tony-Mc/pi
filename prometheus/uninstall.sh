systemctl stop prometheus
systemctl disable prometheus
rm /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl reset-failed
rm /opt/prometheus