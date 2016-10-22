#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${BREW_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${BREW_DOWNLOAD_URL}" "${BREW_INSTALL_FOLDER}" 'tar.gz'
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${BREW_INSTALL_FOLDER}"

    # Update Install Location

    if [[ "${BREW_INSTALL_FOLDER}" != '/usr/local' ]]
    then
        # Update Global Brew

        local -r globalConfigData=('__INSTALL_FOLDER__' "${BREW_INSTALL_FOLDER}")

        createFileFromTemplate "$(dirname "${BASH_SOURCE[0]}")/../templates/brew" '/usr/local/bin/brew' "${globalConfigData[@]}"
        chmod 755 '/usr/local/bin/brew'

        # Update Origin Brew

        local -r originConfigData=('/usr/local' "${BREW_INSTALL_FOLDER}")

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
    local -r installFolder="${1}"

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