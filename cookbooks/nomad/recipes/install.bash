#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${NOMAD_INSTALL_FOLDER_PATH}"
    initializeFolder "${NOMAD_INSTALL_FOLDER_PATH}/bin"

    # Install

    unzipRemoteFile "${NOMAD_DOWNLOAD_URL}" "${NOMAD_INSTALL_FOLDER_PATH}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${NOMAD_INSTALL_FOLDER_PATH}"
    ln -f -s "${NOMAD_INSTALL_FOLDER_PATH}/bin/nomad" '/usr/local/bin/nomad'

    # Display Version

    displayVersion "$("${NOMAD_INSTALL_FOLDER_PATH}/bin/nomad" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING NOMAD'

    install
}

main "${@}"