#!/bin/bash
#
# Run:
#     chmod +x setup.sh
# to make this script executable

echo "+==============================+"
echo "+      Checking for root       +"
echo "+==============================+"
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit
fi
echo "...Done"

echo "+==============================+"
echo "+     Installing packages      +"
echo "+==============================+"
echo "Updating packages..."
apt-get update -y -qq
echo "Upgrading packages..."
apt-get upgrade -y -qq
echo "Installing packages..."
apt-get install -y -qq curl
apt-get install -y -qq git
apt-get install -y -qq vim
apt-get install -y -qq fuse tree bzip2 dos2unix
apt-get install -y -qq build-essential software-properties-common libssl-dev zlib1g-dev
apt-get install -y -qq libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils
apt-get install -y -qq ca-certificates tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
apt-get install -y -qq libpng-dev libjpeg-dev "dotnet-sdk-8.0" ffmpeg flac imagemagick keychain zsh
