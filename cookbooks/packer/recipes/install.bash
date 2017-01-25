#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PACKER_INSTALL_FOLDER_PATH}"
    initializeFolder "${PACKER_INSTALL_FOLDER_PATH}/bin"

    # Install

    unzipRemoteFile "${PACKER_DOWNLOAD_URL}" "${PACKER_INSTALL_FOLDER_PATH}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PACKER_INSTALL_FOLDER_PATH}"
    ln -f -s "${PACKER_INSTALL_FOLDER_PATH}/bin/packer" '/usr/local/bin/packer'

    # Display Version

    displayVersion "$("${PACKER_INSTALL_FOLDER_PATH}/bin/packer" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING PACKER'

    install
}

main "${@}"