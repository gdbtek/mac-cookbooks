#!/bin/bash -e

function install()
{
    compileAndInstallFromSource "${RUBY_DOWNLOAD_URL}" "${RUBY_INSTALL_FOLDER_PATH}" "${RUBY_INSTALL_FOLDER_PATH}/bin" "${SUDO_USER}"
    displayVersion "$(ruby --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING RUBY'

    # Install

    install
}

main "${@}"