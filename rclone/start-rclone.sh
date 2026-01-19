#!/bin/sh

# Start rclone mount in background
rclone mount RealDebridMount: /data/RealDebridMount \
  --config /config/rclone/rclone.conf \
  --allow-other \
  --uid=1000 \
  --gid=1000 \
  --umask=002 \
  --dir-cache-time=10s \
  --vfs-cache-mode=full \
  --log-level=INFO \
  --daemon

# Wait a moment for mount to initialize
sleep 2

# Start rclone web GUI (in foreground)
exec rclone rcd \
  --rc-web-gui \
  --rc-addr=:5572 \
  --rc-no-auth \
  --rc-web-gui-no-open-browser \
  --config=/config/rclone/rclone.conf