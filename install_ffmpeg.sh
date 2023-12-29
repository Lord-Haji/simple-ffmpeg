#!/bin/bash

BASE_URL="https://johnvansickle.com/ffmpeg/releases"

install_ffmpeg() {
    local arch=$1
    local tarball="ffmpeg-release-${arch}-static.tar.xz"
    local download_url="${BASE_URL}/${tarball}"
    local temp_dir=$(mktemp -d) || { echo "Failed to create temp directory"; exit 1; }

    echo "Downloading ffmpeg for ${arch}..."
    wget $download_url -P "$temp_dir" || { echo "Download failed"; exit 1; }

    tar -xf "$temp_dir/$tarball" -C "$temp_dir" || { echo "Extraction failed"; exit 1; }

    local bin_dir=$(find "$temp_dir" -type d -name "ffmpeg-*-static")

    echo "Installing ffmpeg and ffprobe to /usr/local/bin..."
    [ -e /usr/local/bin/ffmpeg ] && sudo rm -rf /usr/local/bin/ffmpeg
    [ -e /usr/local/bin/ffprobe ] && sudo rm -rf /usr/local/bin/ffprobe

    sudo cp "${bin_dir}/ffmpeg" /usr/local/bin/
    sudo cp "${bin_dir}/ffprobe" /usr/local/bin/

    echo "Cleaning up..."
    rm -rf "$temp_dir"
    echo "ffmpeg installation complete."
}

arch=$(uname -m)

case $arch in
    x86_64|amd64) install_ffmpeg "amd64" ;;
    i686) install_ffmpeg "i686" ;;
    armv7l) install_ffmpeg "armhf" ;;
    aarch64) install_ffmpeg "arm64" ;;
    *) echo "Unsupported architecture: $arch"; exit 1 ;;
esac
