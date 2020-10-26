#!/bin/bash
set -e

# * * * * * /bin/bash /opt/stats/temp/push.sh

temp=$(cat "/sys/class/thermal/thermal_zone0/temp")

temp_divided=$(bc -l <<< "$temp/1000")

echo cpu_temp $temp_divided > temp.prom.$$
mv temp.prom.$$ /opt/node_exporter/stats/temp.prom