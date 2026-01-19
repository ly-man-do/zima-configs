#!/bin/sh

# Try multiple unmount methods (ignore errors)
fusermount -uz /data/RealDebridMount 2>/dev/null || true
umount -l /data/RealDebridMount 2>/dev/null || true

# Wait for unmount to complete
sleep 3

# Start rclone mount in background
rclone mount RealDebridMount: /data/RealDebridMount \
  --config=/config/rclone/rclone.conf \
  --allow-non-empty \
  --allow-other \
  --uid=1000 \
  --gid=1000 \
  --umask=002 \
  --dir-cache-time=10s \
  --vfs-cache-mode=full \
  --vfs-cache-max-size=80G \
  --vfs-read-chunk-size=1M \
  --vfs-read-chunk-size-limit=32M \
  --buffer-size=128M \
  --bwlimit=500M \
  --log-level=INFO \
  &

# Get the mount PID
MOUNT_PID=$!

# Wait for mount to initialize
sleep 5

# Check if mount is still running
if ! kill -0 $MOUNT_PID 2>/dev/null; then
  echo "ERROR: Mount process died!"
  exit 1
fi

# Start rclone web GUI (in foreground)
exec rclone rcd \
  --rc-web-gui \
  --rc-addr=:5572 \
  --rc-no-auth \
  --rc-web-gui-no-open-browser \
  --config=/config/rclone/rclone.conf
