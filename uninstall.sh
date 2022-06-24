#!/bin/bash

# vars -------------------------------------------------
install_path=/var/opt/uScripts
links_path=/usr/bin

# main -------------------------------------------------

# Delete previous scripts
if [ -d "$install_path" ]; then
    echo "- Deleting previous scripts"
    rm -rf "$install_path"
fi

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

echo "Finished!"