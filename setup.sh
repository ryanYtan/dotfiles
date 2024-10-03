#!/bin/bash

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

echo "+==============================+"
echo "+     Installing packages      +"
echo "+==============================+"
echo "Updating packages..."
apt-get update -y -qq
echo "Upgrading packages..."
apt-get upgrade -y -qq
echo "Installing packages..."
apt-get install -y -qq \
    build-essential software-properties-common libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils \
    ca-certificates tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    libpng-devlibjpg-dev fuse3 git vim curl tree bzip2 dos2unix \
    "dotnet-sdk-8.0" ffmpeg flac imagemagick keychain zsh \

echo "+==============================+"
echo "+       Installing Docker      +"
echo "+==============================+"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Adding current user to Docker group"
groupadd docker
usermod -aG docker $USER

echo "+==============================+"
echo "+     Installing Kubernetes    +"
echo "+==============================+"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "+==============================+"
echo "+     Installing AWS CLI v2    +"
echo "+==============================+"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm awscliv2.zip

echo "+==============================+"
echo "+    Miscellaneous installs    +"
echo "+==============================+"
echo "You may wish to install Oh-My-Zsh by running"
echo "sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
