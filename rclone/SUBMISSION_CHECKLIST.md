# Rclone Web UI - ZimaOS AppStore Submission Checklist

## Pre-Submission Checklist

### 1. Icon Preparation
- [ ] Download official rclone logo from https://rclone.org
- [ ] Ensure icon is in PNG format (512x512 or similar)
- [ ] Icon has transparent background or appropriate solid color
- [ ] Upload icon to a CDN or GitHub repository
- [ ] Update `icon` URL in docker-compose.yml (service-level and x-casaos level)

**Recommended icon URL format:**
```yaml
icon: https://cdn.jsdelivr.net/gh/YOUR-USERNAME/YOUR-REPO@main/Apps/Rclone/icon.png
```

### 2. Screenshot Preparation
- [ ] Take screenshot of rclone web interface
- [ ] Screenshot shows main features (file browser, transfer monitor, config)
- [ ] Image is high quality (1920x1080 or similar resolution)
- [ ] Upload screenshot to CDN or GitHub repository
- [ ] Update `screenshot_link` URL in docker-compose.yml (line 40-41)

**Recommended screenshot sources:**
- Official rclone website: https://rclone.org/img/webgui-screenshot.png
- Your own installation screenshot

### 3. Testing
- [ ] Install app on ZimaOS test system
- [ ] Verify web UI loads at http://localhost:5572
- [ ] Test adding a cloud remote (Google Drive, Dropbox, etc.)
- [ ] Test file browsing and transfer operations
- [ ] Verify config persistence after container restart
- [ ] Check that /DATA/Media is accessible in container
- [ ] Test on amd64 architecture
- [ ] Test on arm64 architecture (if available)

### 4. Documentation Review
- [ ] Review all metadata in docker-compose.yml
- [ ] Verify all URLs are accessible and correct
- [ ] Check for typos in descriptions
- [ ] Ensure `en_us` is present for all multi-language fields
- [ ] Validate docker-compose.yml syntax

**Validation command:**
```bash
docker-compose -f docker-compose.yml config
```

### 5. GitHub Preparation
- [ ] Fork https://github.com/IceWhaleTech/CasaOS-AppStore
- [ ] Clone your fork locally
- [ ] Create `Apps/Rclone` directory in your fork
- [ ] Copy docker-compose.yml to Apps/Rclone/
- [ ] Copy icon to Apps/Rclone/ (if hosting in the repo)
- [ ] Copy screenshot to Apps/Rclone/ (if hosting in the repo)

### 6. Final Review
- [ ] All file paths are correct
- [ ] Volume mappings use /DATA/AppData structure
- [ ] Port mappings use ${WEBUI_PORT:-5572} format
- [ ] Network mode is set to bridge
- [ ] Container restart policy is "unless-stopped"
- [ ] Architecture list is complete (amd64, arm64, arm)
- [ ] Main service name is correctly referenced in x-casaos.main

### 7. Submission
- [ ] Commit changes to your fork
- [ ] Push to your GitHub repository
- [ ] Create Pull Request to IceWhaleTech/CasaOS-AppStore
- [ ] Provide clear PR description
- [ ] Mention testing performed
- [ ] Wait for community/maintainer review

## Pull Request Template

```markdown
## App Submission: Rclone Web UI

### Description
Rclone is a powerful command-line program to manage files on cloud storage, now with a web-based GUI for easy file management.

### Features
- Support for 40+ cloud storage providers
- Web-based interface for file management
- Real-time transfer monitoring
- Built-in encryption support
- ZimaOS integration with /DATA/Media access

### Testing Performed
- [x] Tested on amd64 architecture
- [ ] Tested on arm64 architecture
- [x] Web UI accessible and functional
- [x] Cloud remote configuration works
- [x] File transfers successful
- [x] Config persistence verified

### Screenshots
[Attach screenshot of the web interface]

### Additional Notes
- No authentication enabled by default (can be configured)
- Uses official rclone/rclone:latest image
- Pre-configured for ZimaOS directory structure
```

## Post-Submission

### If Approved
- [ ] Monitor for user feedback
- [ ] Respond to issues in AppStore repository
- [ ] Consider creating a dedicated support thread in ZimaOS community

### If Changes Requested
- [ ] Review feedback from maintainers
- [ ] Make requested modifications
- [ ] Test changes thoroughly
- [ ] Update pull request
- [ ] Respond to review comments

## Common Issues & Solutions

### Issue: Icon not displaying
**Solution:** 
- Verify icon URL is publicly accessible
- Check CORS settings on hosting platform
- Use jsdelivr CDN for GitHub-hosted files

### Issue: App won't start
**Solution:**
- Check docker-compose.yml syntax
- Verify all volume paths exist
- Check for port conflicts
- Review container logs

### Issue: Authentication problems with cloud providers
**Solution:**
- Ensure OAuth redirect URLs are correctly configured
- Check that ports are accessible from external networks
- Verify cloud provider API credentials

## Resources

- **CasaOS AppStore**: https://github.com/IceWhaleTech/CasaOS-AppStore
- **ZimaOS Docs**: https://www.zimaspace.com/docs/zimaos/Build-Apps
- **Rclone Docs**: https://rclone.org/docs/
- **Community Forum**: https://community.zimaspace.com/

## Notes

- The app uses the official rclone Docker image
- Authentication is disabled by default for ease of use
- Users can enable authentication by modifying container settings
- Config file location follows ZimaOS conventions
- Media folder access provides easy cloud backup functionality

---

**Last Updated:** January 2026
**Status:** Ready for submission
**Maintainer:** [Your GitHub Username]
