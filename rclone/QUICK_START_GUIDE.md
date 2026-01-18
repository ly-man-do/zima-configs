# Rclone Web UI - Quick Start Guide

## What is Rclone?

Rclone is a command-line program that manages files on cloud storage. With the Web UI, you can use Rclone through your browser without typing commands.

## First-Time Setup (5 Minutes)

### Step 1: Access the Web Interface
1. Open your web browser
2. Go to: `http://your-zimaos-ip:5572`
3. The rclone web interface will load

### Step 2: Add Your First Cloud Storage

1. **Click "Config"** in the web interface
2. **Click "Create a new remote"**
3. **Choose your cloud provider** (e.g., Google Drive, Dropbox)
4. **Give it a name** (e.g., "MyGoogleDrive")
5. **Follow the setup wizard:**
   - Select your provider from the list
   - Click through the options (defaults usually work)
   - **Authenticate:** A browser window will open asking you to log in
   - Grant rclone permission to access your files
   - Complete the configuration

6. **Save the configuration**

### Step 3: Browse Your Cloud Files

1. Click "Explorer" in the web interface
2. Select your newly configured remote from the dropdown
3. Browse your cloud files!

## Common Tasks

### Copy Files from ZimaOS to Cloud

1. **Source:** Click the left file browser
   - Navigate to `/data` (this is your `/DATA/Media` folder)
   - Select files/folders you want to backup

2. **Destination:** Click the right file browser
   - Select your cloud remote
   - Choose destination folder

3. **Click "Copy"** button
4. Monitor progress in the "Jobs" tab

### Copy Files from Cloud to ZimaOS

1. **Source:** Select your cloud remote (left browser)
2. **Destination:** Navigate to `/data` (right browser)
3. **Click "Copy"**

### Sync Folders (Keep in Sync)

1. Select source and destination
2. Click "Sync" instead of "Copy"
3. Choose sync direction:
   - **One-way:** Source → Destination
   - **Bi-directional:** Both ways (requires additional setup)

### Monitor Active Transfers

1. Click the "Jobs" tab
2. See all active transfers
3. View progress, speed, and ETA
4. Pause/Resume/Cancel transfers as needed

## Accessing Your ZimaOS Media

In the rclone web interface, `/data` equals your `/DATA/Media` folder on ZimaOS.

**Example folder structure:**
```
/data/
├── Photos/          → Your /DATA/Media/Photos
├── Videos/          → Your /DATA/Media/Videos
├── Music/           → Your /DATA/Media/Music
└── Documents/       → Your /DATA/Media/Documents
```

## Popular Cloud Providers Setup

### Google Drive
1. Select "Google Drive" from provider list
2. Leave defaults
3. Authenticate with Google account
4. Choose drive type (My Drive or Shared Drive)
5. Done!

### Dropbox
1. Select "Dropbox" from provider list
2. Leave defaults
3. Authenticate with Dropbox account
4. Done!

### OneDrive
1. Select "Microsoft OneDrive" from provider list
2. Choose account type (Personal/Business)
3. Authenticate with Microsoft account
4. Done!

### Amazon S3
1. Select "Amazon S3" from provider list
2. Enter Access Key ID and Secret Access Key
3. Choose region
4. Enter bucket name (or leave empty to see all)
5. Done!

## Tips & Best Practices

### 💡 Backup Strategy
- **Copy:** Makes an exact duplicate, doesn't delete anything
- **Sync:** Makes destination identical to source (can delete files!)
- **Always test with small folders first**

### 💡 Speed Optimization
- Rclone automatically optimizes transfer speeds
- Large files transfer faster than many small files
- Network speed is usually the limiting factor

### 💡 Cost Awareness
- Check your cloud provider's storage limits
- Some providers charge for API calls
- Monitor your storage usage

### 💡 Security
- Your authentication tokens are stored in `/DATA/AppData/rclone/config/`
- This folder should be backed up (it contains your cloud credentials)
- Consider enabling authentication in container settings for added security

## Advanced Features

### Encryption
Rclone can encrypt files before uploading to cloud:
1. Create a new remote
2. Select "Crypt" as the type
3. Point it to an existing remote
4. Choose encryption password
5. All files uploaded through this remote will be encrypted

### Bandwidth Limiting
Configure in container settings to avoid saturating your network.

### Scheduled Transfers
Use ZimaOS task scheduler to run rclone commands on a schedule.

## Troubleshooting

### "Cannot access cloud provider"
- **Check:** Internet connection is working
- **Check:** Cloud authentication hasn't expired
- **Solution:** Re-authenticate in Config section

### "Permission denied" errors
- **Check:** You have write permissions on destination
- **Check:** Cloud storage has available space
- **Solution:** Verify permissions in cloud provider

### Transfers are slow
- **Check:** Internet connection speed
- **Check:** Cloud provider API limits
- **Solution:** Normal for large files; be patient

### Web UI won't load
- **Check:** Container is running: `docker ps`
- **Check:** Port 5572 isn't blocked
- **Solution:** Restart container in ZimaOS

## Getting Help

### Official Resources
- **Documentation:** https://rclone.org/docs/
- **Forum:** https://forum.rclone.org/
- **FAQ:** https://rclone.org/faq/

### Community Support
- **ZimaOS Forum:** https://community.zimaspace.com/
- **Reddit:** r/rclone
- **Discord:** ZimaOS community server

## Configuration File Location

Your rclone configuration (including cloud credentials) is stored at:
```
/DATA/AppData/rclone/config/rclone.conf
```

**Important:** 
- Backup this file regularly (it contains your cloud access tokens)
- Don't share this file publicly (it has your credentials)
- Treat it like a password file

## Next Steps

Now that you're set up, try:

1. ✅ Backup your photos to Google Drive
2. ✅ Sync documents to OneDrive
3. ✅ Archive old videos to Backblaze B2
4. ✅ Set up encrypted backups with Crypt
5. ✅ Automate backups with scheduled tasks

Enjoy your cloud-connected ZimaOS! 🚀
