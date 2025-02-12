#!/bin/bash

echo "🔄 Creating systemd service and timer for thumbnail cleanup..."

SERVICE_PATH="/etc/systemd/system/thumbnail-cleaner.service"
TIMER_PATH="/etc/systemd/system/thumbnail-cleaner.timer"

# Create systemd service for cleanup
sudo bash -c "cat > $SERVICE_PATH" <<EOF
[Unit]
Description=Thumbnail Cache Cleaner
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/find ~/.cache/thumbnails -type f -mtime +30 -delete
EOF

# Create systemd timer for weekly cleanup
sudo bash -c "cat > $TIMER_PATH" <<EOF
[Unit]
Description=Runs thumbnail cache cleanup every week

[Timer]
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Reload systemd daemon and enable the timer
sudo systemctl daemon-reload
sudo systemctl enable --now thumbnail-cleaner.timer

echo "✅ Systemd timer activated! Old thumbnails will now be deleted weekly."