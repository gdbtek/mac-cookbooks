#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${SIEGE_DOWNLOAD_URL}" "${SIEGE_INSTALL_FOLDER_PATH}" "${SIEGE_INSTALL_FOLDER_PATH}/bin/siege" "${SUDO_USER}"
    displayVersion "$("${SIEGE_INSTALL_FOLDER_PATH}/bin/siege" --version 2>&1)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING SIEGE'

    install
}

main "${@}"