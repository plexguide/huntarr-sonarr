<h2 align="center">Huntarr - Find Missing & Upgrade Media Items</h2> 

<p align="center">
  <img src="frontend/static/logo/128.png" alt="Huntarr Logo" width="100" height="100">
</p>

---

<h2 align="center">Want to Help? Click the Star in the Upper-Right Corner! ⭐</h2> 

<img src="https://github.com/user-attachments/assets/1ea6ca9c-0909-4b6a-b573-f778b65af8b2" width="100%"/>
 
| Application | Status        |
| :---------- | :------------ |
| Sonarr      | **✅ Ready**  |
| Radarr      | **✅ Ready**  |
| Lidarr      | **✅ Ready**  |
| Readarr     | **✅ Ready**  |
| Whisparr v2 | **✅ Ready**  |
| Whisparr v3 | **✅ Ready**  |
| Bazarr    | **❌ Not Ready** |


Keep in mind this is very early in program development. If you have a very special hand picked collection (because some users are extra special), test before you deploy.

## Table of Contents
- [Overview](#overview)
- [Other Projects](#other-projects)
- [Community](#community)
- [Indexers Approving of Huntarr](#indexers-approving-of-huntarr)
- [How It Works](#how-it-works)
- [Web Interface](#web-interface)
  - [How to Access](#how-to-access)
  - [Web UI Settings](#web-ui-settings)
  - [Volume Mapping](#volume-mapping)
- [Installation Methods](#installation-methods)
  - [Docker Run](#docker-run)
  - [Docker Compose](#docker-compose)
  - [Unraid Users](#unraid-users)
- [Tips](#tips)
- [Troubleshooting](#troubleshooting)
- [Change Log](#change-log)

## Overview

This application continually searches your media libraries for missing content and items that need quality upgrades. It automatically triggers searches for both missing items and those below your quality cutoff. It's designed to run continuously while being gentle on your indexers, helping you gradually complete your media collection with the best available quality.

For detailed documentation, please visit our [Wiki](https://github.com/plexguide/Huntarr/wiki).

## Other Projects

* [Unraid Intel ARC Deployment](https://github.com/plexguide/Unraid_Intel-ARC_Deployment) - Convert videos to AV1 Format (I've saved 325TB encoding to AV1)
* Visit [PlexGuide](https://plexguide.com) for more great scripts

## Community

<p align="center">
  Join the community on Discord!
  <br>
  <a href="https://discord.gg/VQbZCGzQsn" target="_blank">
    <img src="frontend/static/images/discord.png" alt="Discord" width="48" height="48">
  </a>
</p>

## PayPal Donations – For My Daughter's College Fund

My 12-year-old daughter is passionate about singing, dancing, and exploring STEM. She consistently earns A-B honors! Every donation goes directly into her college fund!

[![Donate with PayPal button](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/donate?hosted_button_id=58AYJ68VVMGSC)

## Indexers Approving of Huntarr:
* https://ninjacentral.co.za

## How It Works

### 🔄 Continuous Automation Cycle

#### 1️⃣ Connect & Analyze
Huntarr connects to your Sonarr/Radarr/Lidarr/Readarr instance and analyzes your media library to identify both missing content and potential quality upgrades.

#### 2️⃣ Hunt Missing Content
- 📊 **Smart Selection:** Choose between random or sequential processing
- 🔍 **Efficient Refreshing:** Optionally skip metadata refresh to reduce disk I/O
- 🔮 **Future-Aware:** Automatically skip content with future release dates
- 🎯 **Precise Control:** Set exactly how many items to process per cycle

#### 3️⃣ Hunt Quality Upgrades
- ⬆️ **Quality Improvement:** Find content below your quality cutoff settings
- 📦 **Batch Processing:** Configure exactly how many upgrades to process at once
- 📚 **Large Library Support:** Smart pagination handles even massive libraries
- 🔀 **Flexible Modes:** Choose between random or sequential processing

#### 4️⃣ State Management
- 📝 **History Tracking:** Remembers which items have been processed
- 💾 **Persistent Storage:** State data is saved in the `/config` directory
- ⏱️ **Automatic Reset:** State is cleared after your configured time period (default: 7 days)

#### 5️⃣ Repeat & Rest
Huntarr waits for your configured interval (adjustable in settings) before starting the next cycle. This ensures your indexers aren't overloaded while maintaining continuous improvement of your library.

## Web Interface

Huntarr's live homepage will provide you statics about how many hunts have been pursed regarding missing media and upgrade searches! Note: Numbers reflected are but all required for testing... damn you Whisparr!

<p align="center">
  <img width="100%" alt="image" src="https://github.com/user-attachments/assets/db725ad6-3009-4835-ab44-289dda80d385" />
  <br>
  <em>Homepage</em>
</p>

Huntarr includes a real-time log viewer and settings management web interface that allows you to monitor and configure its operation directly from your browser.

<p align="center">
  <img width="100%" alt="image" src="https://github.com/user-attachments/assets/438e2013-2a54-4cf2-8418-63b0c6124730" />
  <br>
  <em>Logger UI</em>
</p>

### How to Access

The web interface is available on port 9705. Simply navigate to:

```
http://YOUR_SERVER_IP:9705
```

The URL will be displayed in the logs when Huntarr starts, using the same hostname you configured for your API_URL.

### Web UI Settings

The web interface allows you to configure all of Huntarr's settings:

<p align="center">
  <img width="930" alt="image" src="https://github.com/user-attachments/assets/06003622-0af3-4398-a46d-0fa4fb1f455b" />
  <br>
  <em>Settings UI</em>
</p>

### Volume Mapping

To ensure data persistence, make sure you map the `/config` directory to a persistent volume on your host system:

```bash
-v /your-path/appdata/huntarr:/config
```

---

## Installation Methods

### Docker Run

The simplest way to run Huntarr is via Docker (all configuration is done via the web UI):

```bash
docker run -d --name huntarr \
  --restart always \
  -p 9705:9705 \
  -v /your-path/huntarr:/config \
  -e TZ=America/New_York \
  huntarr/huntarr:latest
```

To check on the status of the program, you can use the web interface at http://YOUR_SERVER_IP:9705 or check the logs with:
```bash
docker logs huntarr
```

### Docker Compose

For those who prefer Docker Compose, add this to your `docker-compose.yml` file:

```yaml
services:
  huntarr:
    image: huntarr/huntarr:latest
    container_name: huntarr
    restart: always
    ports:
      - "9705:9705"
    volumes:
      - /your-path/huntarr:/config
    environment:
      - TZ=America/New_York
```

Then run:

```bash
docker-compose up -d huntarr
```

### Unraid Users

Run this from Command Line in Unraid:

```bash
docker run -d --name huntarr \
  --restart always \
  -p 9705:9705 \
  -v /mnt/user/appdata/huntarr:/config \
  -e TZ=America/New_York \
  huntarr/huntarr:latest
```
## Tips

- **First-Time Setup**: Navigate to the web interface after installation to create your admin account with 2FA option
- **API Connections**: Configure connections to your *Arr applications through the dedicated settings pages
- **Search Frequency**: Adjust Sleep Duration (default: 900 seconds) based on your indexer's rate limits.
- **Batch Processing**: Set Hunt Missing and Upgrade values to control how many items are processed per cycle
- **Queue Management**: Use Minimum Download Queue Size to pause searching when downloads are backed up
- **Skip Processing**: Enable Skip Series/Movie Refresh to significantly reduce disk I/O and database load
- **Future Content**: Keep Skip Future Items enabled to avoid searching for unreleased content
- **Authentication**: Enable two-factor authentication for additional security on your Huntarr instance

## Troubleshooting

- **API Connection Issues**: Verify your API key and URL in the Settings page (check for missing http:// or https://)
- **Config URLs**: It is best practice to omit the trailing slash (/) at the end of the URL for each service.  i.e. For Sonarr, instead of http://10.10.10.1:8989/ use http://10.10.10.1:8989.  This is the most common cause of errors seen in the log each time a cycle runs.
- **Authentication Problems**: If you forget your password, delete `/config/user/credentials.json` and restart
- **Two-Factor Authentication**: If locked out of 2FA, remove credentials file to reset your account
- **Web Interface Not Loading**: Confirm port 9705 is correctly mapped and not blocked by firewalls
- **Logs Not Showing**: Check permissions on the `/config/logs/` directory inside your container
- **Missing State Data**: State files in `/config/stateful/` track processed items; verify permissions
- **Docker Volume Issues**: Ensure your volume mount for `/config` has correct permissions and ownership
- **Command Timeouts**: Adjust command_wait_attempts and command_wait_delay in advanced settings
- **Debug Information**: Enable Debug Mode temporarily to see detailed API responses in the logs

## Change Log
Visit: https://github.com/plexguide/Huntarr/releases/
