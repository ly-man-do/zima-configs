# Troubleshooting Guide

## Issue: Container Fails to Start with "unknown command" Error

### Error Message
```
Error: unknown command "rcd --rc-web-gui --rc-addr :5572 --rc-no-auth --rc-web-gui-no-open-browser --config /config/rclone/rclone.conf" for "rclone"
Run 'rclone --help' for usage.
NOTICE: Fatal error: unknown command...
```

### Root Cause
Docker Compose was interpreting the entire command string as a single command instead of separating the command (`rcd`) from its arguments (`--rc-web-gui`, etc.).

### Solution
The command must be in **array format** (YAML list), not string format.

**❌ WRONG (String Format):**
```yaml
command: rcd --rc-web-gui --rc-addr :5572 --rc-no-auth --config /config/rclone/rclone.conf
```

**✅ CORRECT (Array Format):**
```yaml
command:
  - rcd
  - --rc-web-gui
  - --rc-addr
  - :5572
  - --rc-no-auth
  - --rc-web-gui-no-open-browser
  - --config
  - /config/rclone/rclone.conf
```

### What Changed
Each argument is now a separate item in a YAML list, allowing Docker to properly parse:
- Command: `rcd`
- Arguments: `--rc-web-gui`, `--rc-addr`, `:5572`, etc.

### How to Fix Your Installation

1. **Stop the container:**
   ```bash
   docker-compose down
   ```

2. **Update docker-compose.yml** with the corrected array format above

3. **Restart the container:**
   ```bash
   docker-compose up -d
   ```

4. **Verify it's running:**
   ```bash
   docker-compose logs -f
   ```

   You should now see:
   ```
   NOTICE: Downloading webgui binary. Please wait...
   NOTICE: Serving remote control on http://0.0.0.0:5572/
   ```

5. **Access the web UI:**
   - Navigate to `http://your-zimaos-ip:5572`

## Other Common Issues

### Issue: Web UI Downloads Every Time Container Starts

**Symptom:**
```
NOTICE: A new release for gui is present...
NOTICE: Downloading webgui binary. Please wait...
```

**Cause:** The web GUI cache is not persisted between container restarts.

**Solution:** The GUI is cached in `/root/.cache/rclone/webgui/` inside the container. This is normal on first start. Subsequent restarts should use the cached version.

### Issue: Cannot Access Web UI from Network

**Symptom:** Web UI works on localhost but not from other devices.

**Solution:**
1. Verify port mapping in docker-compose.yml:
   ```yaml
   ports:
     - target: 5572
       published: ${WEBUI_PORT:-5572}
       protocol: tcp
   ```

2. Check firewall settings on ZimaOS

3. Verify the container is using `--rc-addr :5572` (not `127.0.0.1:5572`)

### Issue: Config Not Persisting

**Symptom:** Cloud remote configurations are lost after container restart.

**Solution:**
1. Verify volume mapping:
   ```yaml
   volumes:
     - type: bind
       source: /DATA/AppData/$AppID/config
       target: /config/rclone
   ```

2. Check directory exists and has correct permissions:
   ```bash
   ls -la /DATA/AppData/rclone/config/
   ```

3. Ensure config file is created:
   ```bash
   cat /DATA/AppData/rclone/config/rclone.conf
   ```

### Issue: Permission Denied Errors

**Symptom:**
```
Failed to create file system for "remote:": failed to open config file: permission denied
```

**Solution:**
1. Check PUID/PGID match your user:
   ```yaml
   environment:
     - PUID=$PUID
     - PGID=$PGID
   ```

2. Fix directory permissions:
   ```bash
   sudo chown -R $PUID:$PGID /DATA/AppData/rclone/
   ```

### Issue: OAuth Authentication Fails

**Symptom:** Browser opens but OAuth flow doesn't complete.

**Solution:**
1. Ensure you're accessing from the same network as ZimaOS
2. Try using the ZimaOS IP address instead of localhost
3. Check cloud provider hasn't blocked the OAuth request
4. Some providers require specific redirect URIs - check their documentation

### Issue: Transfers Are Slow

**Symptom:** File transfers are slower than expected.

**Solution:**
1. Check network bandwidth
2. Increase buffer size:
   ```yaml
   command:
     - rcd
     - --rc-web-gui
     - --rc-addr
     - :5572
     - --buffer-size
     - 128M
     - --rc-no-auth
     - --rc-web-gui-no-open-browser
     - --config
     - /config/rclone/rclone.conf
   ```

3. Increase number of transfers:
   ```yaml
   - --transfers
   - "8"
   ```

## Getting More Help

### Check Container Logs
```bash
docker logs rclone
# or
docker-compose logs -f
```

### Verify Container Status
```bash
docker ps -a
# or
docker-compose ps
```

### Test Rclone Manually
```bash
docker exec -it rclone rclone version
docker exec -it rclone rclone config show
```

### Official Resources
- **Rclone Forum:** https://forum.rclone.org/
- **GitHub Issues:** https://github.com/rclone/rclone/issues
- **Documentation:** https://rclone.org/docs/
- **ZimaOS Community:** https://community.zimaspace.com/

## Quick Verification Commands

After fixing the command format, verify everything works:

```bash
# 1. Check container is running
docker ps | grep rclone

# 2. Check logs for successful start
docker logs rclone | grep "Serving remote control"

# 3. Test web UI is accessible
curl -I http://localhost:5572

# 4. Verify config directory exists
ls -la /DATA/AppData/rclone/config/
```

Expected successful output:
- Container shows "Up" status
- Logs show "Serving remote control on http://0.0.0.0:5572/"
- Curl returns HTTP 200 OK
- Config directory exists and is writable
