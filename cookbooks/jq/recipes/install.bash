#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${JQ_INSTALL_FOLDER}"
    initializeFolder "${JQ_INSTALL_FOLDER}/bin"

    # Install

    downloadFile "${JQ_DOWNLOAD_URL}" "${JQ_INSTALL_FOLDER}/bin/jq" 'true'
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${JQ_INSTALL_FOLDER}"
    chmod 755 "${JQ_INSTALL_FOLDER}/bin/jq"
    symlinkLocalBin "${JQ_INSTALL_FOLDER}/bin"

    # Display Version

    displayVersion "$("${JQ_INSTALL_FOLDER}/bin/jq" --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING JQ'

    install
}

main "${@}"