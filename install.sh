#!/bin/bash

# vars -------------------------------------------------
branch_name="$1"
github_repo=https://github.com/ucabreragonzalez/uScripts.git
temp_path=$(mktemp -d)
install_path=/var/opt/uScripts
links_path=/usr/bin

# main -------------------------------------------------

# Clone repo to get the specified branch
git clone $github_repo --branch $branch_name --single-branch $temp_path

# Create install folder if does not exists
if [ ! -d "$install_path" ]; then
    mkdir -p "$install_path"
fi

# If previos scripts then delete
find $install_path -maxdepth 1 -type f -delete
# find /path/to/directory -xtype l -delete

# Copy scripts
cp $temp_path/scripts/* $install_path/