#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${AUTOMAKE_DOWNLOAD_URL}" "${AUTOMAKE_INSTALL_FOLDER_PATH}" "${AUTOMAKE_INSTALL_FOLDER_PATH}/bin/automake" "${SUDO_USER}"
    displayVersion "$("${AUTOMAKE_INSTALL_FOLDER_PATH}/bin/automake")"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING AUTOMAKE'

    install
}

main "${@}"