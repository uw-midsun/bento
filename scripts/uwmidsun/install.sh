#!/bin/sh -eux

# Remove repo if it exists
rm -rf uwmidsun-provisioning

# Clone latest
git clone https://github.com/karlding/uwmidsun-provisioning.git
uwmidsun-provisioning/install.sh

# Move to home directory
cp -r uwmidsun-provisioning/dotfiles ~/dotfiles

# Clean up
rm -rf uwmidsun-provisioning
