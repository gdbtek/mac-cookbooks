#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${VAULT_INSTALL_FOLDER_PATH}"
    initializeFolder "${VAULT_INSTALL_FOLDER_PATH}/bin"

    # Install

    unzipRemoteFile "${VAULT_DOWNLOAD_URL}" "${VAULT_INSTALL_FOLDER_PATH}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${VAULT_INSTALL_FOLDER_PATH}"
    ln -f -s "${VAULT_INSTALL_FOLDER_PATH}/bin/vault" '/usr/local/bin/vault'

    # Display Version

    displayVersion "$("${VAULT_INSTALL_FOLDER_PATH}/bin/vault" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING VAULT'

    install
}

main "${@}"