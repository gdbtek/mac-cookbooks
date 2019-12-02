#!/bin/bash -e

source "$(dirname "${BASH_SOURCE[0]}")/util.bash"

######################
# COMMAND LINE TOOLS #
######################

function installCommandLineTools()
{
    header 'INSTALLING COMMAND LINE TOOLS'

    xcode-select --install || true
}

########################
# VIRTUALBOX UTILITIES #
########################

function installVirtualBoxUSRLocalBinFiles()
{
    header 'INSTALLING VIRTUAL-BOX USR-LOCAL-BIN FILES'

    local -r virtualBoxMacOSFolderPath='/Applications/VirtualBox.app/Contents/MacOS'

    if [[ -d "${virtualBoxMacOSFolderPath}" ]]
    then
        mkdir -p '/usr/local/bin'

        find "${virtualBoxMacOSFolderPath}" \
            -mindepth 1 \
            -maxdepth 1 \
            -type f \
            -perm -755 \
            -not -name '*.*' \
            -exec cp -f -p '{}' '/usr/local/bin' \; \
            -print
    fi
}