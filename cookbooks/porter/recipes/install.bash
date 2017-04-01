#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PORTER_INSTALL_FOLDER_PATH}"
    initializeFolder "${PORTER_INSTALL_FOLDER_PATH}/bin"

    # Install

    unzipRemoteFile "${PORTER_DOWNLOAD_URL}" "${PORTER_INSTALL_FOLDER_PATH}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PORTER_INSTALL_FOLDER_PATH}"
    ln -f -s "${PORTER_INSTALL_FOLDER_PATH}/bin/porter" '/usr/local/bin/porter'

    # Display Version

    displayVersion "$("${PORTER_INSTALL_FOLDER_PATH}/bin/porter" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING PORTER'

    install
}

main "${@}"