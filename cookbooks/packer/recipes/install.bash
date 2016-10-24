#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PACKER_INSTALL_FOLDER}"
    initializeFolder "${PACKER_INSTALL_FOLDER}/bin"

    # Install

    unzipRemoteFile "${PACKER_DOWNLOAD_URL}" "${PACKER_INSTALL_FOLDER}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PACKER_INSTALL_FOLDER}"
    ln -f -s "${PACKER_INSTALL_FOLDER}/bin/packer" '/usr/local/bin/packer'

    # Display Version

    displayVersion "$("${PACKER_INSTALL_FOLDER}/bin/packer" version)"
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
    installCleanUp
}

main "${@}"