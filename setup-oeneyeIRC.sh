#!/bin/bash
set -e
wget -q https://github.com/ergochat/ergo/releases/latest/download/ergo-2.14.0-linux-x64.tar.gz
tar xzf ergo-*.tar.gz
sudo mv ergo /usr/local/bin/ergo
sudo mkdir -p /etc/ergo
sudo ergo mkconf --conf /etc/ergo/ircd.yaml --force
sudo sed -i 's/name:.*/name: irc.oeneye.net/' /etc/ergo/ircd.yaml
sudo sed -i 's/network-name:.*/network-name: oeneyeIRC/' /etc/ergo/ircd.yaml
echo "Config created at /etc/ergo/ircd.yaml"
echo "Set your oper password:"
ergo genpasswd
