#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${GO_LANG_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${GO_LANG_DOWNLOAD_URL}" "${GO_LANG_INSTALL_FOLDER}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${GO_LANG_INSTALL_FOLDER}"

    symlinkLocalBin "${GO_LANG_INSTALL_FOLDER}/bin"
    ln -f -s "${GO_LANG_INSTALL_FOLDER}" '/usr/local/go'
    rm -f -r "${GO_LANG_INSTALL_FOLDER}/$(basename "${GO_LANG_INSTALL_FOLDER}")"

    # Display Version

    export GOROOT="${GO_LANG_INSTALL_FOLDER}"
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