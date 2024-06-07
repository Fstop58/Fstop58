#!/bin/bash
echo "$(date '+%Y-%m-%d %H:%M:%S') - $common_name disconnected" >> /var/log/openvpn/disconnect.log
