# Zurg - ZimaOS Docker App

A self-hosted Real-Debrid WebDAV server for ZimaOS that enables you to mount your Real-Debrid torrent library into your filesystem. Perfect for use with Plex, Jellyfin, and Infuse.

## 📋 Table of Contents

- [About Zurg](#about-zurg)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Integration with Plex/Jellyfin](#integration-with-plexjellyfin)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)
- [Support](#support)

## About Zurg

Zurg is a high-performance WebDAV server for Real-Debrid written from scratch. Together with rclone, it can mount your Real-Debrid torrent library into your filesystem just like Dropbox, making it seamless to use with media servers.

### Why Zurg?

- **Better Performance**: Changes in your library appear instantly
- **Flexible Configuration**: Configure directory structures via `config.yml`
- **Reliability**: Comprehensive torrent health checking prevents Plex scanner from getting stuck
- **Repair Abilities**: Guarantees your library is always available
- **No Duplicates**: Merges torrents with the same name intelligently

## Features

✅ **WebDAV Server** - Access your Real-Debrid library via WebDAV  
✅ **Plex/Jellyfin Integration** - Works seamlessly with media servers  
✅ **Infuse Support** - Direct WebDAV connection for iOS/Apple TV  
✅ **Automatic Repairs** - Keeps your library healthy and available  
✅ **Smart Filtering** - Organize content by type (movies, shows, anime)  
✅ **Instant Updates** - Library changes appear immediately  
✅ **Health Checks** - Prevents media server scanner issues  

## Prerequisites

1. **Real-Debrid Account**  
   - Sign up at: https://real-debrid.com
   - Get your API token from: https://real-debrid.com/apitoken

2. **ZimaOS** (version 1.0 or higher)

3. **Optional**: Rclone app (for mounting to filesystem)

## Installation

### Via ZimaOS App Store

1. Open the ZimaOS App Store
2. Search for "Zurg"
3. Click "Install"
4. Wait for installation to complete

### Manual Installation

1. Download the `docker-compose.yaml` file
2. Place it in your preferred directory
3. Run: `docker compose up -d`

## Configuration

### 🔴 CRITICAL: Configure Before Use

Zurg **will not work** until you configure it with your Real-Debrid API token.

### Step 1: Get Your Real-Debrid API Token

1. Log in to Real-Debrid
2. Visit: https://real-debrid.com/apitoken
3. Copy your API token

### Step 2: Edit Configuration File

#### Location
```
/DATA/AppData/zurg/config/config.yml
```

#### Edit the Token
Find this line:
```yaml
token: yourtoken
```

Replace `yourtoken` with your actual Real-Debrid API token:
```yaml
token: YOUR_ACTUAL_TOKEN_HERE
```

### Step 3: Restart Zurg

After editing the config:

**Via ZimaOS UI:**
1. Go to Apps
2. Find Zurg
3. Click "Restart"

**Via Command Line:**
```bash
docker compose restart zurg
```

### Step 4: Verify Installation

1. Open your browser
2. Navigate to: `http://your-zimaos-ip:9999`
3. You should see the Zurg WebDAV server

## Usage

### Accessing the WebDAV Server

**WebDAV URL**: `http://localhost:9999`

### For Infuse (iOS/Apple TV)

1. Open Infuse
2. Add a new source
3. Select "WebDAV"
4. Enter:
   - **Server**: Your ZimaOS IP address
   - **Port**: 9999
   - **Path**: `/`
5. Save and browse your library

### Default Directory Structure

After configuration, Zurg creates these directories:

```
/
├── anime/     # Anime content
├── shows/     # TV shows
└── movies/    # Movies
```

## Integration with Plex/Jellyfin

To use Zurg with Plex or Jellyfin, you need to mount the WebDAV share using rclone.

### Step 1: Install Rclone

Install the Rclone app from the ZimaOS App Store

### Step 2: Configure Rclone

Create an rclone config file at `/DATA/AppData/rclone/config/rclone.conf`:

```ini
[zurg]
type = webdav
url = http://zurg:9999
vendor = other
```

### Step 3: Mount with Rclone

Use rclone to mount Zurg:

```bash
rclone mount zurg: /mnt/zurg --allow-other --allow-non-empty --dir-cache-time 10s
```

### Step 4: Add to Plex/Jellyfin

1. In Plex/Jellyfin, add a new library
2. Point it to: `/mnt/zurg/movies` or `/mnt/zurg/shows`
3. Scan library

## Troubleshooting

### Web Interface Not Loading

**Problem**: Cannot access http://localhost:9999

**Solutions**:
1. Check if container is running:
   ```bash
   docker ps | grep zurg
   ```
2. Check logs:
   ```bash
   docker logs zurg
   ```
3. Verify port 9999 is not in use:
   ```bash
   netstat -tulpn | grep 9999
   ```

### No Content Showing

**Problem**: Directories are empty

**Solutions**:
1. Verify your Real-Debrid API token is correct
2. Check if you have torrents in your Real-Debrid account
3. Review Zurg logs for errors:
   ```bash
   docker logs zurg
   ```

### "Invalid Token" Error

**Problem**: Zurg shows authentication errors

**Solutions**:
1. Regenerate your API token at: https://real-debrid.com/apitoken
2. Update `config.yml` with the new token
3. Restart the container

### Using Outside Home Network

If using Zurg on a server outside your home network:

1. Log in to Real-Debrid
2. Go to your Account page
3. **UNCHECK** "Use my Remote Traffic automatically when needed"
4. Save settings

## Advanced Configuration

### Custom Directory Filters

Edit `config.yml` to customize how content is organized:

```yaml
directories:
  4k_movies:
    group_order: 40
    group: media
    only_show_the_biggest_file: true
    filters:
      - regex: /2160p|4K|UHD/
  
  documentaries:
    group_order: 50
    group: media
    filters:
      - regex: /documentary|docs/i
```

### Enable Plex Auto-Updates

Uncomment this line in `config.yml`:

```yaml
on_library_update: sh plex_update.sh "$@"
```

### Performance Tuning

Adjust these settings in `config.yml`:

```yaml
concurrent_workers: 20           # Increase for better performance
check_for_changes_every_secs: 5  # Faster library updates
network_buffer_size: 8388608     # 8MB buffer
```

### Authentication

To add password protection:

```yaml
username: your_username
password: your_password
```

## File Locations

| Description | Path |
|------------|------|
| Config File | `/DATA/AppData/zurg/config/config.yml` |
| Data Directory | `/DATA/AppData/zurg/data` |
| Docker Compose | `/DATA/AppData/zurg/docker-compose.yaml` |

## Docker Commands

### View Logs
```bash
docker logs zurg
```

### Follow Logs
```bash
docker logs -f zurg
```

### Restart Container
```bash
docker compose restart zurg
```

### Stop Container
```bash
docker compose stop zurg
```

### Update Zurg
```bash
docker compose pull
docker compose up -d
```

## Support

### Official Resources

- **GitHub**: https://github.com/debridmediamanager/zurg-testing
- **Wiki**: https://github.com/debridmediamanager/zurg-testing/wiki
- **Sponsor/Support**: https://patreon.com/debridmediamanager

### Community Guides

- [Zurg Configuration Guide](https://github.com/debridmediamanager/zurg-testing/wiki/Config)
- [Debrid Wiki - Zurg](https://debrid.wiki/docs/zurg)
- [Savvy Guides - Zurg](https://savvyguides.wiki/zurg/)

### Getting Help

1. Check the [Wiki](https://github.com/debridmediamanager/zurg-testing/wiki)
2. Review [existing issues](https://github.com/debridmediamanager/zurg-testing/issues)
3. Create a new issue with:
   - Zurg version
   - Configuration (with token removed)
   - Logs output
   - Steps to reproduce

## Version

This app uses **Zurg v0.9.3-final** (stable public release)

For the latest sponsor-only version (v0.10.x), see the [official repository](https://github.com/debridmediamanager/zurg).

## Credits

- **Zurg**: Created by [@yowmamasita](https://github.com/yowmamasita)
- **ZimaOS App**: Packaged for CasaOS/ZimaOS community

## License

Zurg is developed and maintained by debridmediamanager. Please support the project through [Patreon](https://patreon.com/debridmediamanager) to access the latest features.

---

**⚠️ Remember**: Always configure your Real-Debrid API token before expecting Zurg to work!
