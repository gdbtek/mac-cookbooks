#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${AUTOCONF_DOWNLOAD_URL}" "${AUTOCONF_INSTALL_FOLDER_PATH}" "${AUTOCONF_INSTALL_FOLDER_PATH}/bin/autoconf" "${SUDO_USER}"
    displayVersion "$("${AUTOCONF_INSTALL_FOLDER_PATH}/bin/autoconf")"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING AUTOCONF'

    install
}

main "${@}"