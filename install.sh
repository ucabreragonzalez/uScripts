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

# If previous scripts then delete
echo "- Deleting previous scripts"
find $install_path -maxdepth 1 -type f -delete
arrLinks=$(find $links_path -xtype l)
arrLinks=(${arrLinks})
for index in ${!arrLinks[*]}
do
    link_path=${arrLinks[index]}
    tmp=$(ls -l $link_path)

    if [[ "$tmp" == *"uScripts"* ]]; then
        echo "- Deleting link: $link_path"
        unlink $link_path
    fi
done

# Copy scripts
echo "- copying scripts into $install_path/"
cp $temp_path/scripts/* $install_path/
chmod +x $install_path/*

#Create new links
arrScripts=$(find $install_path -maxdepth 1 -type f)
arrScripts=(${arrScripts})
for index in ${!arrScripts[*]}
do
    script_path=${arrScripts[index]}
    tmp=(${script_path//// })
    script_name=${tmp[-1]}

    echo "- creating link: $script_name"
	ln -s $install_path/$script_name $links_path/$script_name
done

echo "Finished!"