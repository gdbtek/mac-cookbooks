#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${BREW_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${BREW_DOWNLOAD_URL}" "${BREW_INSTALL_FOLDER}" 'tar.gz'

    #"${BREW_INSTALL_FOLDER}/bin/brew" doctor
    #"${BREW_INSTALL_FOLDER}/bin/brew" update

    symlinkLocalBin "${BREW_INSTALL_FOLDER}/bin"

    # Display Version

    displayVersion "$(brew -v)"
}

function main()
{
    local -r installFolder="${1}"

    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem

    header 'INSTALLING BREW'

    # Install

    install
}

main "${@}"