# box64-debs

Automated Debian repository for [box64](https://github.com/ptitSeb/box64) built specifically for the Raspberry Pi 5 ARM64 target. This repository automatically tracks upstream releases and builds signed packages using GitHub Actions.

## How it works
- **Automated Updates**: A GitHub Actions workflow runs daily at 1 AM UTC and can be triggered manually
- **Release Tracking**: Monitors [ptitSeb/box64](https://github.com/ptitSeb/box64) for new releases using the GitHub API
- **Smart Building**: Only builds when a new upstream release is detected (tracked in `last_release.txt`)
- **Signed Packages**: All packages and repository metadata are GPG-signed for security
- **Target**: RPI5ARM64 with ARM_DYNAREC, BOX32, and BOX32_BINFMT enabled

The compiled packages are available in the `debian/` folder: https://github.com/atoll6/box64-debs/tree/master/debian

## Repository Installation
Add the signed repository to your system for automatic updates and security verification:

```bash
# Clean up any existing configurations
if [ -f /etc/apt/sources.list.d/box64.list ]; then
  sudo rm -f /etc/apt/sources.list.d/box64.list || exit 1
fi
if [ -f /etc/apt/sources.list.d/box64.sources ]; then
  sudo rm -f /etc/apt/sources.list.d/box64.sources || exit 1
fi

# Download and install the GPG signing key
if [ -f /usr/share/keyrings/box64-archive-keyring.gpg ]; then
  sudo rm -f /usr/share/keyrings/box64-archive-keyring.gpg
fi
sudo mkdir -p /usr/share/keyrings
wget -qO- "https://atoll6.github.io/box64-debs/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/box64-archive-keyring.gpg

# Add the repository using modern .sources format
echo "Types: deb
URIs: https://atoll6.github.io/box64-debs/debian
Suites: ./
Signed-By: /usr/share/keyrings/box64-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/box64.sources >/dev/null

# Update package list and install
sudo apt update
sudo apt install box64-rpi5arm64 -y
```

## Alternative Installation Methods

### Direct Download from Repository
If you don't want to add the APT repository to your system, you can download and install packages directly:

1. Browse the [debian folder](https://github.com/atoll6/box64-debs/tree/master/debian)
2. Download the latest `box64-rpi5arm64_*.deb` file
3. Install with: `sudo dpkg -i box64-rpi5arm64_*.deb`
4. Fix any dependencies: `sudo apt install -f`

### GitHub Releases
Each upstream release also creates a corresponding GitHub release with the `.deb` file attached:
- Visit: https://github.com/atoll6/box64-debs/releases
- Download the latest `box64-rpi5arm64_*.deb` file
- Install as above

## Build Information
- **Build Environment**: Ubuntu 24.04 ARM runners
- **CMake Flags**: `-DRPI5ARM64=1 -DARM_DYNAREC=ON -DBOX32=ON -DBOX32_BINFMT=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo`
- **Package Tool**: checkinstall
- **Upstream Source**: https://github.com/ptitSeb/box64
