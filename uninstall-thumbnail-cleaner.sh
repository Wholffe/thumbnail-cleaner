#!/bin/bash

echo "🗑 Removing systemd timer and service..."

# Disable and remove timer and service
sudo systemctl disable --now thumbnail-cleaner.timer
sudo rm /etc/systemd/system/thumbnail-cleaner.service
sudo rm /etc/systemd/system/thumbnail-cleaner.timer
sudo systemctl daemon-reload

echo "✅ Thumbnail Cleaner successfully removed!"