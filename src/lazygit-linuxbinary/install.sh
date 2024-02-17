#!/bin/bash -i

set -e


source ./library_scripts.sh



# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.5.0"

clean_download  "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" /tmp/lazygit_version
LAZYGIT_VERSION=$(cat /tmp/lazygit_version | grep -Po '"tag_name": "v\K[^"]*')
rm -f /tmp/lazygit_version
if [[ $(uname -m) == "x86_64" ]]; then
    clean_download "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" lazygit.tar.gz 
elif [[ $(uname -m) == "aarch64" ]]; then
    clean_download "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz" lazygit.tar.gz 
else
    echo "Unsupported architecture"
    exit 1
fi
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin
