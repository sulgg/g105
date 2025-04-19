#!/bin/bash

sudo apt update

# https://starship.rs/
sudo curl -sS https://starship.rs/install.sh | sh -s -- -y
echo "starship installed ✅"

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
echo "eza installed ✅"


# Remove the existing .zshrc file if it exists
if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
    echo ".zshrc removed ✅"
fi
# Create a symbolic link to .devcontainer/zshrc
ln -s /workspaces/g105/.devcontainer/zshrc ~/.zshrc
echo "Symbolic link to .devcontainer/zshrc created ✅"

# Check if the .config folder exists
if [ -d ~/.config ]; then
    # Remove existing starship.toml link or file if it exists
    if [ -f ~/.config/starship.toml ] || [ -L ~/.config/starship.toml ]; then
        rm ~/.config/starship.toml
        echo "Existing starship.toml removed ✅"
    fi
    # Create a symbolic link to .devcontainer/starship.toml
    ln -s /workspaces/g105/.devcontainer/starship.toml ~/.config/starship.toml
    echo "Symbolic link to .devcontainer/starship.toml created ✅"
else
    echo "~/.config folder does not exist ❌"
fi