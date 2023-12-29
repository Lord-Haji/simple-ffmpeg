#!/bin/bash

RELEASE_URL="https://johnvansickle.com/ffmpeg/releases"
GIT_URL="https://johnvansickle.com/ffmpeg/builds"

install_ffmpeg() {
    local url=$1
    local arch=$2
    local build_type=$3
    local tarball="ffmpeg-${build_type}-${arch}-static.tar.xz"
    local download_url="${url}/${tarball}"
    local temp_dir=$(mktemp -d) || { echo "Failed to create temp directory"; exit 1; }

    local build_desc="release"
    if [ "$build_type" == "git" ]; then
        build_desc="latest Git"
    fi
    echo "Downloading the $build_desc build of ffmpeg for ${arch}..."

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

# Set the url and build type based on the command line argument
url=$RELEASE_URL
build_type="release"
if [[ "$1" == "-g" ]] || [[ "$1" == "--git" ]]; then
    url=$GIT_URL
    build_type="git"
fi

# Install ffmpeg based on the architecture and build type
case $arch in
    x86_64|amd64) install_ffmpeg $url "amd64" $build_type ;;
    i686) install_ffmpeg $url "i686" $build_type ;;
    armv7l) install_ffmpeg $url "armhf" $build_type ;;
    aarch64) install_ffmpeg $url "arm64" $build_type ;;
    *) echo "Unsupported architecture: $arch"; exit 1 ;;
esac