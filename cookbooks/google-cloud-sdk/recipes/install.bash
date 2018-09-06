#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}"
# rm -f '/usr/local/bin/aws'

    # Install

    local -r tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${GOOGLE_CLOUD_SDK_DOWNLOAD_URL}" "${tempFolder}"
    "${tempFolder}/install"
    rm -f -r "${tempFolder}"

    # Display Version

    #displayVersion "$("${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}/bin/aws" --version 2>&1)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING GOOGLE-CLOUD-SDK'

    install
}

main "${@}"