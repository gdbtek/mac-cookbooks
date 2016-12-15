#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${MAVEN_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${MAVEN_DOWNLOAD_URL}" "${MAVEN_INSTALL_FOLDER}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${MAVEN_INSTALL_FOLDER}"
    ln -f -s "${MAVEN_INSTALL_FOLDER}/bin/mvn" '/usr/local/bin/mvn'

    # Display Version

    displayVersion "$("${MAVEN_INSTALL_FOLDER}/bin/mvn" -v)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING MAVEN'

    install
    installCleanUp
}

main "${@}"