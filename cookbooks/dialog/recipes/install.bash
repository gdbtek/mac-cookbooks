#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${DIALOG_INSTALL_FOLDER_PATH}"

    # Install

    local -r tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${DIALOG_DOWNLOAD_URL}" "${tempFolder}"
    cd "${tempFolder}"
    "${tempFolder}/configure" --prefix="${DIALOG_INSTALL_FOLDER_PATH}"
    make
    make install
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${DIALOG_INSTALL_FOLDER_PATH}"
    ln -f -s "${DIALOG_INSTALL_FOLDER_PATH}/bin/dialog" '/usr/local/bin/dialog'
    rm -f -r "${tempFolder}"

    # Display Version

    displayVersion "$(dialog --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING DIALOG'

    # Install

    install
}

main "${@}"