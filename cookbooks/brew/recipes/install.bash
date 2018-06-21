#!/bin/bash -e

function install()
{
    local -r DEFAULT_INSTALL_FOLDER_PATH='/usr/local'

    # Clean Up

    if [[ "${BREW_INSTALL_FOLDER_PATH}" != "${DEFAULT_INSTALL_FOLDER_PATH}" ]]
    then
        initializeFolder "${BREW_INSTALL_FOLDER_PATH}"
    fi

    rm -f -r "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    # Install

    unzipRemoteFile "${BREW_DOWNLOAD_URL}" "${BREW_INSTALL_FOLDER_PATH}" 'tar.gz'
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${BREW_INSTALL_FOLDER_PATH}"

    # Update Install Location

    if [[ "${BREW_INSTALL_FOLDER_PATH}" != "${DEFAULT_INSTALL_FOLDER_PATH}" ]]
    then
        # Update Global Brew

        createAbsoluteBin 'brew' "${BREW_INSTALL_FOLDER_PATH}/bin/brew"

        # Update Origin Brew

        local -r originConfigData=("${DEFAULT_INSTALL_FOLDER_PATH}" "${BREW_INSTALL_FOLDER_PATH}")

        createFileFromTemplate "${BREW_INSTALL_FOLDER_PATH}/bin/brew" "${BREW_INSTALL_FOLDER_PATH}/bin/brew" "${originConfigData[@]}"
    fi

    # Update

    su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER_PATH}/bin/brew doctor || true"
    su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER_PATH}/bin/brew update"

    # Display Version

    displayVersion "$(su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER_PATH}/bin/brew -v")"
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
}

main "${@}"