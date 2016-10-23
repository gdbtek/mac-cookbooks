#!/bin/bash -e

function install()
{
    local -r DEFAULT_INSTALL_FOLDER='/usr/local'

    # Clean Up

    if [[ "${BREW_INSTALL_FOLDER}" != "${DEFAULT_INSTALL_FOLDER}" ]]
    then
        initializeFolder "${BREW_INSTALL_FOLDER}"
    fi

    # Install

    unzipRemoteFile "${BREW_DOWNLOAD_URL}" "${BREW_INSTALL_FOLDER}" 'tar.gz'
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${BREW_INSTALL_FOLDER}"

    # Update Install Location

    if [[ "${BREW_INSTALL_FOLDER}" != "${DEFAULT_INSTALL_FOLDER}" ]]
    then
        # Update Global Brew

        createAbsoluteLocalBin 'brew' "${BREW_INSTALL_FOLDER}/bin/brew"

        # Update Origin Brew

        local -r originConfigData=("${DEFAULT_INSTALL_FOLDER}" "${BREW_INSTALL_FOLDER}")

        createFileFromTemplate "${BREW_INSTALL_FOLDER}/bin/brew" "${BREW_INSTALL_FOLDER}/bin/brew" "${originConfigData[@]}"
    fi

    # Update

    su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER}/bin/brew doctor || true"
    su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER}/bin/brew update"

    # Display Version

    displayVersion "$(su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER}/bin/brew -v")"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING BREW'

    # Install

    install
    installCleanUp
}

main "${@}"