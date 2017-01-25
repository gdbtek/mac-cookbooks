#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${AWS_CLI_INSTALL_FOLDER_PATH}"
    rm -f '/usr/local/bin/aws'

    # Install

    local -r tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${AWS_CLI_DOWNLOAD_URL}" "${tempFolder}"
    python "${tempFolder}/awscli-bundle/install" -b '/usr/local/bin/aws' -i "${AWS_CLI_INSTALL_FOLDER_PATH}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${AWS_CLI_INSTALL_FOLDER_PATH}"
    chmod 755 "${AWS_CLI_INSTALL_FOLDER_PATH}/bin/aws"
    rm -f -r "${tempFolder}"

    # Display Version

    displayVersion "$("${AWS_CLI_INSTALL_FOLDER_PATH}/bin/aws" --version 2>&1)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING AWS-CLI'

    install
}

main "${@}"