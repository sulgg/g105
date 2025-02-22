#!/bin/bash

sudo apt update

# https://github.com/sharkdp/bat
sudo apt install -y bat
# executable may be installed as batcat instead of bat
# set up a bat -> batcat symlink
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
echo "bat installed ✅"

# https://github.com/BurntSushi/ripgrep
sudo apt-get install ripgrep
echo "ripgrep installed ✅"

# https://github.com/eza-community/eza
# Install GPG if not already installed
sudo apt install -y gpg
# Create the keyrings directory if it doesn't exist
sudo mkdir -p /etc/apt/keyrings
# Download the GPG key and convert it to the required format
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
    sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# Add the new repository to the sources list
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
    sudo tee /etc/apt/sources.list.d/gierens.list
# Set proper permissions for the key and list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
# Update the package list
sudo apt update
# Install eza
sudo apt install -y eza
# add eza alias to bashrc
{
    echo -e "alias ll='eza -l --group-directories-first'"
    echo -e "alias l='eza --group-directories-first'"
    echo -e "alias la='eza -la --group-directories-first'"
} >>~/.bashrc
# Print success message
echo "eza installed ✅"
