#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${PARALLEL_DOWNLOAD_URL}" "${PARALLEL_INSTALL_FOLDER_PATH}" "${PARALLEL_INSTALL_FOLDER_PATH}/bin/parallel" "${SUDO_USER}"
    displayVersion "$(parallel --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING PARALLEL'

    # Install

    install
}

main "${@}"