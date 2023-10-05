#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#Init Var
NODE_IP=`hostname -I | awk '{print $1}'`
USER="ansible"
PASSWORD=`openssl rand -base64 16`


# Init ansible user
sudo useradd -m $USER
sudo usermod --password $(echo $PASSWORD | openssl passwd -1 -stdin) $USER
sudo usermod -aG sudo $USER


# Forwarding IPv4 and letting iptables see bridged traffic
# https://kubernetes.io/docs/setup/production-environment/container-runtimes/#forwarding-ipv4-and-letting-iptables-see-bridged-traffic
sudo cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system


#Prompt
echo "${GREEN}"
echo "==="
echo "NODE IP: $NODE_IP"
echo "USER: $USER"
echo "PASSWORD: $PASSWORD"
echo "${NC}"
