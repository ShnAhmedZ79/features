#!/bin/bash -i

set -e
sudo apt-get install -y curl
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if [[ $(uname -m) == "x86_64" ]]; then
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
elif [[ $(uname -m) == "aarch64" ]]; then
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
else
    echo "Unsupported architecture"
    exit 1
fi
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
