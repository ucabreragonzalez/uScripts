#!/bin/bash

# vars -------------------------------------------------
branch_name="$1"
github_repo=https://github.com/ucabreragonzalez/uScripts.git
temp_path=$(mktemp -d)
install_path=/var/opt/uScripts

# main -------------------------------------------------
# Clone repo to get the specified branch
git clone $github_repo --branch $branch_name --single-branch $temp_path


alias create-folder="$temp_path/scripts/create-folder"
alias test-folder="$temp_path/scripts/test-folder"

# cd $temp_path
create-folder "$G_SCRIPTS_PATH"