# simple-ffmpeg

Welcome to the `simple-ffmpeg` repository! This script offers a straightforward method for installing `ffmpeg` and `ffprobe` on Linux systems. It's crafted to be quick, efficient, and reliable.

## Background

This script was created out of necessity as Amazon Linux 2 and Amazon Linux 2023 did not include ffmpeg in their dnf repositories. It's designed to fill this gap, providing an easy way for users of these distributions to install ffmpeg in a [one line command](#quick-start)

## Features

- **Easy Installation**: Just one command to install `ffmpeg`.
- **Linux-Specific**: Tailored exclusively for Linux environments.
- **Automatic Cleanup**: Neat and tidy, with no mess left behind.

## Prerequisites

Before proceeding, ensure you have:
- A Linux-based operating system (Note: This script is specifically designed for Linux and is not compatible with other operating systems).
- `sudo` privileges on your system.
- `curl` installed for downloading the script.

## Quick Start

Install `ffmpeg` using this simple command:

**Stable Release:**

```bash
curl -L https://raw.githubusercontent.com/Lord-Haji/simple-ffmpeg/main/simple_ffmpeg.sh | sudo bash
```

**Bleeding Edge Git Build: (Add -g or --git flag as standard input)**

```bash
curl -L https://raw.githubusercontent.com/Lord-Haji/simple-ffmpeg/main/simple_ffmpeg.sh | sudo bash -s -- -g
```

## How It Works

The script:
1. Detects the system architecture.
2. Downloads the right `ffmpeg` build from [John Van Sickle's website](https://johnvansickle.com/ffmpeg/).
3. Extracts and places `ffmpeg` and `ffprobe` in `/usr/local/bin`.
4. Cleans up after the installation.

## Supported Architectures

- `x86_64`
- `i686`
- `armv7l`
- `aarch64`


## License

Open-sourced under the [MIT license](https://opensource.org/licenses/MIT).

## Disclaimer

Provided "as is", without any warranty. Use at your own risk.

