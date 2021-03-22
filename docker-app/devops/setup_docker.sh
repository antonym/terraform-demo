#!/usr/bin/env bash
set -x

# Sets up an ubuntu 20.04 host for Docker


# Unattended
export DEBIAN_FRONTEND=noninteractive
export APT="sudo apt-get -y"

# Uninstall crufty docker
${APT} remove \
    docker \
    docker-engine \
    docker.io \
    containerd \
    runc

# Install docker deps
${APT} update
${APT} install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Unfathomable gpg keys
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set repo to `stable`
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Now we do the installs
${APT} update
${APT} install \
    docker-ce \
    docker-ce-cli \
    containerd.io