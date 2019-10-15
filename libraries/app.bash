#!/bin/bash -e

########################
# VIRTUALBOX UTILITIES #
########################

function resetVirtualBoxUSRLocalBinFiles()
{
    local -r virtualBoxMacOSFolderPath='/Applications/VirtualBox.app/Contents/MacOS'

    if [[ -d "${virtualBoxMacOSFolderPath}" ]]
    then
        mkdir -p '/usr/local/bin'

        find \
            "${virtualBoxMacOSFolderPath}" \
            -mindepth 1 -maxdepth 1 \
            -type f \
            -perm -755 \
            -not -name '*.*' \
            -exec cp -f -p '{}' '/usr/local/bin' \; \
            -print
    fi
}