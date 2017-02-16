#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${SHELL_CHECK_DOWNLOAD_URL}" "${SHELL_CHECK_INSTALL_FOLDER_PATH}" "${SHELL_CHECK_INSTALL_FOLDER_PATH}/bin/shellcheck" "${SUDO_USER}"
    displayVersion "$(shellcheck -V)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING SHELL-CHECK'

    # Install

    install
}

main "${@}"