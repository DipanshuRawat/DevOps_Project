#!/bin/bash

set -e

# Variables
ALERTMANAGER_VERSION="0.20.0"
DOWNLOAD_URL="https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz"

echo "🔵 Creating alertmanager user and group..."
sudo useradd -M -r -s /bin/false alertmanager || echo "User already exists, skipping."

echo "🔵 Downloading Alertmanager v$ALERTMANAGER_VERSION..."
wget $DOWNLOAD_URL -O /tmp/alertmanager.tar.gz

echo "🔵 Extracting Alertmanager..."
cd /tmp
tar xvfz alertmanager.tar.gz

echo "🔵 Installing Alertmanager binary..."
sudo cp alertmanager-${ALERTMANAGER_VERSION}.linux-amd64/alertmanager /usr/local/bin/
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager

echo "🔵 Setting up configuration..."
sudo mkdir -p /etc/alertmanager
sudo cp alertmanager-${ALERTMANAGER_VERSION}.linux-amd64/alertmanager.yml /etc/alertmanager
sudo chown -R alertmanager:alertmanager /etc/alertmanager

echo "🔵 Creating storage directory..."
sudo mkdir -p /var/lib/alertmanager
sudo chown alertmanager:alertmanager /var/lib/alertmanager

echo "🔵 Creating systemd service for Alertmanager..."
sudo bash -c 'cat <<EOF > /etc/systemd/system/alertmanager.service
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --storage.path=/var/lib/alertmanager/

[Install]
WantedBy=multi-user.target
EOF'

echo "🔵 Reloading systemd..."
sudo systemctl daemon-reload

echo "🔵 Enabling and starting Alertmanager service..."
sudo systemctl enable alertmanager
sudo systemctl start alertmanager

echo "✅ Alertmanager setup complete!"
echo "🔗 Access it at http://localhost:9093"
