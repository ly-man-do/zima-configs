# ZimaOS App Store Submission Checklist

Complete checklist for submitting Zurg to the CasaOS/ZimaOS App Store.

## 📋 Pre-Submission Checklist

### Required Files
- [x] `docker-compose.yaml` - Main app configuration
- [x] `README.md` - Comprehensive documentation
- [x] `config.yml` - Sample configuration file
- [ ] App icon (PNG/SVG format)
- [ ] Screenshots (at least 1)

### Configuration Review
- [x] Correct Docker image: `ghcr.io/debridmediamanager/zurg-testing:v0.9.3-final`
- [x] Proper port configuration (9999)
- [x] Volume mappings are correct
- [x] Health check configured
- [x] Network settings proper
- [x] Environment variables documented
- [x] ZimaOS metadata complete

### Documentation
- [x] Installation instructions clear
- [x] Configuration steps detailed
- [x] Troubleshooting section included
- [x] Integration guides (Plex/Jellyfin)
- [x] Quick start guide created
- [x] Tips section for before_install

## 🎨 Asset Preparation

### 1. Icon Requirements
- **Format**: PNG or SVG
- **Size**: 512x512 pixels minimum
- **Background**: Transparent preferred
- **Content**: Clear, recognizable logo

**Current Icon URL (UPDATE THIS)**:
```yaml
icon: https://raw.githubusercontent.com/debridmediamanager/zurg-testing/main/.github/assets/zurg-icon.png
```

### 2. Screenshot Requirements
- **Format**: PNG or JPG
- **Size**: 1920x1080 recommended
- **Content**: Show main interface
- **Annotations**: Helpful but optional

**Current Screenshot URL (UPDATE THIS)**:
```yaml
screenshot_link:
  - https://raw.githubusercontent.com/debridmediamanager/zurg-testing/main/.github/assets/zurg-screenshot.png
```

### 3. Hosting Options for Assets

**Option A: GitHub Repository**
1. Create a new repository or use existing
2. Add images to repository
3. Use raw.githubusercontent.com URLs
4. Example:
   ```
   https://raw.githubusercontent.com/USERNAME/REPO/main/zurg-icon.png
   ```

**Option B: CDN (jsDelivr)**
1. Upload to GitHub
2. Use jsDelivr CDN:
   ```
   https://cdn.jsdelivr.net/gh/USERNAME/REPO@main/zurg-icon.png
   ```

**Option C: Direct from Zurg Repository**
Check if icons exist in the official repository:
- https://github.com/debridmediamanager/zurg-testing

## 🚀 Submission Process

### Step 1: Fork the AppStore Repository

```bash
# Visit GitHub and fork:
https://github.com/IceWhaleTech/CasaOS-AppStore

# Clone your fork
git clone https://github.com/YOUR-USERNAME/CasaOS-AppStore.git
cd CasaOS-AppStore
```

### Step 2: Create App Directory

```bash
# Create Zurg directory
mkdir -p Apps/Zurg

# Copy files
cp docker-compose.yaml Apps/Zurg/docker-compose.yaml
cp config.yml Apps/Zurg/config.yml
```

### Step 3: Add Assets (if hosting in repo)

```bash
# Optional: Add icon and screenshots to the repository
cp zurg-icon.png Apps/Zurg/icon.png
cp zurg-screenshot.png Apps/Zurg/screenshot.png
```

### Step 4: Update Asset URLs

If you're hosting assets in the AppStore repository:

```yaml
# In docker-compose.yaml, update:
icon: https://cdn.jsdelivr.net/gh/IceWhaleTech/CasaOS-AppStore@main/Apps/Zurg/icon.png
screenshot_link:
  - https://cdn.jsdelivr.net/gh/IceWhaleTech/CasaOS-AppStore@main/Apps/Zurg/screenshot.png
```

### Step 5: Test the Configuration

```bash
# Validate YAML syntax
docker-compose -f Apps/Zurg/docker-compose.yaml config

# Test deployment locally
cd Apps/Zurg
docker-compose up -d

# Verify it works
curl http://localhost:9999
```

### Step 6: Commit and Push

```bash
# Add files
git add Apps/Zurg/

# Commit
git commit -m "Add Zurg app for Real-Debrid WebDAV server"

# Push to your fork
git push origin main
```

### Step 7: Create Pull Request

1. Visit your fork on GitHub
2. Click "Pull Request"
3. Set base repository: `IceWhaleTech/CasaOS-AppStore`
4. Set base branch: `main`
5. Title: `Add Zurg - Real-Debrid WebDAV Server`
6. Description:
   ```markdown
   ## Zurg - Real-Debrid WebDAV Server
   
   This PR adds Zurg, a self-hosted Real-Debrid WebDAV server for ZimaOS.
   
   **What is Zurg?**
   - High-performance WebDAV server for Real-Debrid
   - Enables mounting Real-Debrid library to filesystem
   - Works with Plex, Jellyfin, and Infuse
   - Version: v0.9.3-final (stable)
   
   **Testing:**
   - [x] Tested on ZimaOS
   - [x] Docker compose validated
   - [x] Configuration verified
   - [x] Documentation complete
   
   **Links:**
   - Upstream: https://github.com/debridmediamanager/zurg-testing
   - Docker Image: ghcr.io/debridmediamanager/zurg-testing
   ```
7. Click "Create Pull Request"

## 📝 Post-Submission

### Monitor Your PR
- Watch for review comments
- Respond promptly to feedback
- Make requested changes if needed

### Update Process
```bash
# If changes are requested:
# 1. Make changes locally
# 2. Commit
git commit -am "Address review feedback"
# 3. Push
git push origin main
```

## ✅ Final Checks

Before submitting, verify:

- [ ] All URLs are accessible
- [ ] Icon displays correctly
- [ ] Screenshots are clear
- [ ] Description is accurate
- [ ] Installation works from scratch
- [ ] Configuration instructions are clear
- [ ] No sensitive information (tokens, passwords) in files
- [ ] Proper attribution to original author
- [ ] License information included

## 📚 Additional Resources

- [CasaOS AppStore Guidelines](https://github.com/IceWhaleTech/CasaOS-AppStore)
- [Docker Compose File Reference](https://docs.docker.com/compose/compose-file/)
- [Zurg Official Documentation](https://github.com/debridmediamanager/zurg-testing/wiki)

## 🎯 Expected Timeline

- **Submission**: Immediate
- **Initial Review**: 1-7 days
- **Revisions** (if needed): 1-3 days per cycle
- **Final Approval**: 1-2 weeks total

## 💡 Tips for Faster Approval

1. **Test thoroughly** before submitting
2. **Follow existing app patterns** in the repository
3. **Provide clear documentation**
4. **Use proper formatting** in YAML files
5. **Include helpful descriptions** for users

---

Good luck with your submission! 🚀
