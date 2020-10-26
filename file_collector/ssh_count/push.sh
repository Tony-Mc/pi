#!/bin/bash
set -e

# * * * * * /bin/bash /opt/stats/ssh_count/push.sh

count=$(who | grep -v localhost | wc -l)

echo ssh_count $count  > ssh_count.prom.$$
mv ssh_count.prom.$$ /opt/node_exporter/stats/ssh_count.prom
