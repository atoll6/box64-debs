#!/bin/bash

set -e

echo "Installing box64 for Raspberry Pi 5 ARM64..."

# Clean up any existing configurations
sudo rm -f /etc/apt/sources.list.d/box64.list /etc/apt/sources.list.d/box64.sources

# Install GPG key
sudo mkdir -p /usr/share/keyrings
wget -qO- "https://atoll6.github.io/box64-debs/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/box64-archive-keyring.gpg

# Add repository
echo "Types: deb
URIs: https://atoll6.github.io/box64-debs/debian
Suites: ./
Signed-By: /usr/share/keyrings/box64-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/box64.sources >/dev/null

# Install
sudo apt update
sudo apt install box64-rpi5arm64 -y

echo "Installation complete!"