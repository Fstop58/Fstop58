#!/bin/bash
echo "$(date '+%Y-%m-%d %H:%M:%S') - $common_name connected with IP $ifconfig_pool_remote_ip" >> /var/log/openvpn/connect.log
