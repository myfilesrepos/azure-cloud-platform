#!/bin/bash
set -e

echo "========== STARTING VM BOOTSTRAP =========="

# System Update
apt-get update -y
# Base Packages
apt-get install -y \
  curl wget git unzip jq \
  apt-transport-https ca-certificates gnupg lsb-release software-properties-common

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Helm
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# kubelogin
curl -LO https://github.com/Azure/kubelogin/releases/latest/download/kubelogin-linux-amd64.zip
apt-get install -y unzip
unzip kubelogin-linux-amd64.zip -d kubelogin
install -o root -g root -m 0755 \
  kubelogin/bin/linux_amd64/kubelogin \
  /usr/local/bin/kubelogin
rm -rf kubelogin kubelogin-linux-amd64.zip
