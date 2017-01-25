#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${CONSUL_INSTALL_FOLDER_PATH}"
    initializeFolder "${CONSUL_INSTALL_FOLDER_PATH}/bin"

    # Install

    unzipRemoteFile "${CONSUL_DOWNLOAD_URL}" "${CONSUL_INSTALL_FOLDER_PATH}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${CONSUL_INSTALL_FOLDER_PATH}"
    ln -f -s "${CONSUL_INSTALL_FOLDER_PATH}/bin/consul" '/usr/local/bin/consul'

    # Display Version

    displayVersion "$("${CONSUL_INSTALL_FOLDER_PATH}/bin/consul" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING CONSUL'

    install
}

main "${@}"