#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${DIALOG_DOWNLOAD_URL}" "${DIALOG_INSTALL_FOLDER_PATH}" "${DIALOG_INSTALL_FOLDER_PATH}/bin/dialog" "${SUDO_USER}"
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