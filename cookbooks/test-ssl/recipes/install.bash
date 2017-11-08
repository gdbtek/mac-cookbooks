#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${TEST_SSL_INSTALL_FOLDER_PATH}"

    # Install

    unzipRemoteFile "${TEST_SSL_DOWNLOAD_URL}" "${TEST_SSL_INSTALL_FOLDER_PATH}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${TEST_SSL_INSTALL_FOLDER_PATH}"
    ln -f -s "${TEST_SSL_INSTALL_FOLDER_PATH}/testssl.sh" '/usr/local/bin/testssl'

    # Display Version

    displayVersion "$("${TEST_SSL_INSTALL_FOLDER_PATH}/testssl.sh" -v)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING TEST-SSL'

    install
}

main "${@}"