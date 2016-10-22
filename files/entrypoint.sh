#!/bin/bash

# Docker entrypoint script
# Executes original command

# Summary:
# --------
# * Set up script
# * Set up correct variables
# * Set dns configuration
# * Execute command

# Set up script
set -e
set -o pipefail


# Set up correct variables
if [[ `ping -c1 dnsmasq` ]]
then
	echo "Using \"dnsmasq\" as DNS"
	DNS="dnsmasq"
else
	echo "Using default DNS"
    DNS="8.8.8.8"
fi


# Set dns configuration
if [[ -f /etc/openvpn/openvpn.conf ]]
then
    sed -ri "s/push dhcp-option DNS.+/push dhcp-option DNS $DNS/g" /etc/openvpn/openvpn.conf
else
    echo "No openvpn configuration found!"
    exit 1
fi


# Execute command
if [[ $@ ]]
then
    exec "$@"
else
    ovpn_run
fi
