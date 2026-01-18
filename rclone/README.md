# Rclone Web UI - ZimaOS Docker App

A ZimaOS Docker App package for Rclone with Web GUI enabled, allowing you to manage cloud storage through an intuitive web interface.

## Key Updates Based on Official ZimaOS Apps

This app has been structured following the official ZimaOS/CasaOS AppStore standards based on apps like Plex, Jellyfin, and N8n:

- ✅ Uses `docker-compose.yml` (not `.yaml`)
- ✅ Includes top-level `name:` field
- ✅ Uses `$AppID`, `$PUID`, `$PGID`, `$TZ` system variables
- ✅ Proper x-casaos metadata with service-level environment/port/volume descriptions
- ✅ Includes required fields: `store_app_id`, `hostname`, `author_url`, `project_url`
- ✅ Simplified formatting (no markdown in descriptions)
- ✅ Uses bridge network with proper port mapping

## Features

- **40+ Cloud Providers Supported**: Google Drive, Dropbox, OneDrive, S3, Backblaze B2, and more
- **Web-based GUI**: Manage files, transfers, and remotes through your browser
- **Real-time Monitoring**: Track active transfers and bandwidth usage
- **Built-in Encryption**: Encrypt files before uploading to cloud storage
- **Mount Support**: Mount cloud storage as local filesystem
- **ZimaOS Integration**: Pre-configured paths for Media access

## Installation

### Method 1: Via ZimaOS App Store (Once Published)
1. Open ZimaOS App Store
2. Search for "Rclone Web UI"
3. Click Install
4. Access at `http://your-zimaos-ip:5572`

### Method 2: Manual Installation
1. Save the `docker-compose.yml` file to your ZimaOS
2. Import the compose file through ZimaOS Docker management
3. Start the container

### Method 3: Command Line
```bash
# Create config directory
mkdir -p /DATA/AppData/rclone/config

# Deploy using docker-compose
docker-compose up -d
```

## Usage

### First-Time Setup

1. **Access the Web UI**
   - Navigate to `http://your-zimaos-ip:5572`
   - The interface will load automatically

2. **Configure Cloud Remotes**
   - Click on "Config" in the web interface
   - Click "Create a new remote"
   - Follow the wizard to add your cloud provider
   - Authenticate with your cloud account (OAuth window will open)
   - Complete the configuration

3. **Start Using Rclone**
   - Browse files on your remotes
   - Copy/Sync between local and cloud storage
   - Create backup jobs
   - Monitor transfers in real-time

### Common Operations

**Copy files to cloud:**
- Select source (local `/data` = your `/DATA/Media`)
- Select destination (your cloud remote)
- Click "Copy"

**Sync directories:**
- Use "Sync" operation to keep directories in sync
- Configure one-way or two-way sync

**Mount cloud storage:**
- Available through command-line operations
- Requires additional configuration

## Configuration

### Directory Structure

```
/DATA/AppData/rclone/
└── config/
    └── rclone.conf        # Rclone configuration file
```

Note: The actual path uses `$AppID` variable which expands to the app name, ensuring proper separation if multiple instances are needed.

### Volume Mappings

| Host Path | Container Path | Purpose |
|-----------|---------------|---------|
| `/DATA/AppData/$AppID/config` | `/config/rclone` | Rclone configuration and remotes |
| `/DATA/Media` | `/data` | Access to ZimaOS Media folder |

### Port Configuration

| Port | Protocol | Purpose |
|------|----------|---------|
| 5572 | HTTP | Web UI access |

### Adding Authentication (Optional)

For added security, you can enable username/password authentication:

1. Stop the container
2. Edit the container settings in ZimaOS
3. Modify the command to include authentication:
   ```
   rcd --rc-web-gui --rc-addr :5572 --rc-user YOUR_USERNAME --rc-pass YOUR_PASSWORD --config /config/rclone/rclone.conf
   ```
4. Restart the container

## Advanced Configuration

### Environment Variables

- `PUID=1000` - User ID for file permissions
- `PGID=1000` - Group ID for file permissions
- `TZ=Etc/UTC` - Timezone setting

### Additional Flags

You can modify the command in the docker-compose file to add more flags:

- `--rc-user USERNAME` - Set username for authentication
- `--rc-pass PASSWORD` - Set password for authentication
- `--rc-allow-origin http://another-domain.com` - Allow CORS from specific domain
- `--log-level INFO` - Set logging level (DEBUG, INFO, NOTICE, ERROR)
- `--buffer-size 128M` - Set buffer size for transfers
- `--transfers 4` - Number of parallel transfers

## Supported Cloud Providers

- **Google Drive** - Personal and Workspace accounts
- **Dropbox** - Personal and Business
- **OneDrive** - Personal, Business, SharePoint
- **Amazon S3** - And S3-compatible storage
- **Backblaze B2**
- **Google Cloud Storage**
- **Microsoft Azure Blob Storage**
- **Box**
- **Mega**
- **pCloud**
- **WebDAV**
- **SFTP/SSH**
- And 30+ more providers!

## Troubleshooting

### Web UI Not Loading
- Check if container is running: `docker ps`
- Check logs: `docker logs rclone`
- Verify port 5572 is not in use by another service

### Cannot Access Cloud Storage
- Ensure you've configured remotes in the Config section
- Check authentication tokens haven't expired
- Review logs for API errors

### Permission Errors
- Verify PUID/PGID match your ZimaOS user
- Check directory permissions on `/DATA/AppData/rclone/config`

### Config File Missing
- The config directory will be created on first run
- If missing, manually create: `mkdir -p /DATA/AppData/rclone/config`

## Submitting to ZimaOS App Store

### Prerequisites
1. GitHub account
2. Fork of the CasaOS-AppStore repository
3. Icon and screenshot images

### Submission Steps

1. **Prepare Assets**
   - Create/obtain an icon (SVG or PNG format)
   - Take screenshots of the web interface
   - Upload to a CDN or GitHub repository

2. **Update Icon URLs**
   - Edit `docker-compose.yml`
   - Update the `icon` and `screenshot_link` URLs to your hosted images
   - Example: `https://cdn.jsdelivr.net/gh/YOUR-USERNAME/YOUR-REPO@main/icon.png`

3. **Fork the AppStore**
   ```bash
   # Fork the repository on GitHub
   https://github.com/IceWhaleTech/CasaOS-AppStore
   
   # Clone your fork
   git clone https://github.com/YOUR-USERNAME/CasaOS-AppStore.git
   cd CasaOS-AppStore
   ```

4. **Add Your App**
   ```bash
   # Create app directory
   mkdir -p Apps/Rclone
   
   # Copy files
   cp /path/to/docker-compose.yml Apps/Rclone/docker-compose.yml
   cp /path/to/icon.png Apps/Rclone/icon.png
   cp /path/to/screenshot.png Apps/Rclone/screenshot.png
   ```

5. **Test Your App**
   - Install on your ZimaOS system
   - Verify all functionality works
   - Test on different architectures if possible (amd64, arm64)

6. **Submit Pull Request**
   ```bash
   git add Apps/Rclone/
   git commit -m "Add Rclone Web UI app"
   git push origin main
   ```
   - Go to your GitHub fork
   - Click "Pull Request"
   - Provide description of the app
   - Submit for review

### Icon Requirements
- **Format**: SVG (preferred) or PNG
- **Source**: Use official rclone logo from https://rclone.org
- **Size**: 512x512 pixels minimum for PNG
- **Background**: Transparent or solid color

### Screenshot Requirements
- **Format**: PNG or JPEG
- **Source**: Official screenshots or your own
- **Quality**: High resolution, clear UI elements
- **Content**: Show main features and interface

## Resources

- **Official Documentation**: https://rclone.org/docs/
- **Web GUI Documentation**: https://rclone.org/gui/
- **Community Forum**: https://forum.rclone.org/
- **GitHub Repository**: https://github.com/rclone/rclone
- **ZimaOS Documentation**: https://www.zimaspace.com/docs/zimaos/

## License

Rclone is licensed under the MIT License. This ZimaOS app package is provided as-is for community use.

## Support

- **Rclone Issues**: Report to https://github.com/rclone/rclone/issues
- **ZimaOS App Issues**: Create issue in the CasaOS-AppStore repository
- **Community Help**: Visit https://forum.rclone.org/

## Credits

- **Rclone Development Team**: https://rclone.org/
- **ZimaOS Team**: https://www.zimaspace.com/
- **App Package**: Created for the ZimaOS community
