# Zurg Quick Start Guide

Get up and running with Zurg in 5 minutes!

## Prerequisites

✅ Real-Debrid account (https://real-debrid.com)  
✅ Real-Debrid API token (https://real-debrid.com/apitoken)  
✅ ZimaOS installed and running

## Quick Setup (5 Steps)

### Step 1: Install Zurg

1. Open ZimaOS App Store
2. Search for "Zurg"
3. Click "Install"

### Step 2: Get Your API Token

1. Visit: https://real-debrid.com/apitoken
2. Copy your API token

### Step 3: Configure Zurg

1. Navigate to: `/DATA/AppData/zurg/config/`
2. Edit `config.yml`
3. Replace `yourtoken` with your actual API token:
   ```yaml
   token: YOUR_REAL_DEBRID_TOKEN_HERE
   ```
4. Save the file

### Step 4: Restart Zurg

In ZimaOS:
- Go to Apps
- Find Zurg
- Click "Restart"

### Step 5: Test Access

Open your browser and go to:
```
http://your-zimaos-ip:9999
```

You should see your Real-Debrid library!

## Next Steps

### Option A: Use with Infuse (iOS/Apple TV)

1. Open Infuse
2. Add WebDAV source:
   - **Server**: Your ZimaOS IP
   - **Port**: 9999
3. Browse and play your media

### Option B: Use with Plex/Jellyfin

1. Install Rclone app from ZimaOS App Store
2. Configure rclone to connect to Zurg:
   ```ini
   [zurg]
   type = webdav
   url = http://zurg:9999
   vendor = other
   ```
3. Mount with rclone:
   ```bash
   rclone mount zurg: /mnt/zurg --allow-other
   ```
4. Add `/mnt/zurg/movies` and `/mnt/zurg/shows` to your Plex/Jellyfin libraries

## Common Issues

### ❌ Can't access web interface
- Check if Zurg is running: `docker ps | grep zurg`
- Check port 9999 isn't blocked

### ❌ No content showing
- Verify your API token is correct
- Make sure you have torrents in your Real-Debrid account
- Check logs: `docker logs zurg`

### ❌ Using outside home network
- Disable "Use my Remote Traffic automatically when needed" in your Real-Debrid account settings

## Directory Structure

Zurg organizes your content into:

```
/
├── anime/    # Anime shows
├── shows/    # TV series
└── movies/   # Movies
```

## Tips

💡 **Update Library Faster**: Set `check_for_changes_every_secs: 5` in config.yml  
💡 **Better Performance**: Increase `concurrent_workers: 30`  
💡 **Add Authentication**: Set `username` and `password` in config.yml  

## Need Help?

- 📚 Full README: See `README.md`
- 🌐 Official Wiki: https://github.com/debridmediamanager/zurg-testing/wiki
- 💬 Community: https://debrid.wiki/docs/zurg

---

**That's it!** You're now streaming from Real-Debrid with Zurg 🎉
