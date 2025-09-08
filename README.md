# box64-debs

Debian packages for [box64](https://github.com/ptitSeb/box64) built for Raspberry Pi 5 ARM64. New packages are automatically built and released when upstream releases a new version.

## Installation

### APT Repository (Recommended)
Add the repository for automatic updates:

```bash
# Clean up any existing configurations
sudo rm -f /etc/apt/sources.list.d/box64.list /etc/apt/sources.list.d/box64.sources

# Install GPG key
sudo mkdir -p /usr/share/keyrings
wget -qO- "https://atoll6.github.io/box64-debs/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/box64-archive-keyring.gpg

# Add repository
echo "Types: deb
URIs: https://atoll6.github.io/box64-debs/debian
Suites: ./
Signed-By: /usr/share/keyrings/box64-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/box64.sources >/dev/null

# Install
sudo apt update
sudo apt install box64-rpi5arm64 -y
```

### Direct Download
Download packages from [Releases](https://github.com/atoll6/box64-debs/releases) and install manually:

```bash
# Download the latest .deb file, then:
sudo apt install -y ./box64-rpi5arm64_*.deb
```

## About
- **Target**: Raspberry Pi 5 ARM64 only
- **Features**: Includes BOX32 support for 32-bit x86 applications
- **Updates**: Automatically tracks [ptitSeb/box64](https://github.com/ptitSeb/box64) releases
