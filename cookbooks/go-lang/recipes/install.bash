#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${GO_LANG_INSTALL_FOLDER_PATH}"

    # Install

    unzipRemoteFile "${GO_LANG_DOWNLOAD_URL}" "${GO_LANG_INSTALL_FOLDER_PATH}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${GO_LANG_INSTALL_FOLDER_PATH}"

    symlinkLocalBin "${GO_LANG_INSTALL_FOLDER_PATH}/bin"
    ln -f -s "${GO_LANG_INSTALL_FOLDER_PATH}" '/usr/local/go'
    rm -f -r "${GO_LANG_INSTALL_FOLDER_PATH}/$(basename "${GO_LANG_INSTALL_FOLDER_PATH}")"

    # Display Version

    export GOROOT="${GO_LANG_INSTALL_FOLDER_PATH}"
    displayVersion "$(go version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING GO-LANG'

    # Install

    install
}

main "${@}"