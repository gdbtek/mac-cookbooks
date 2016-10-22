#!/bin/bash -e

function install()
{
    su -l "${SUDO_USER}" -c "${BREW_INSTALL_FOLDER}/bin/brew install shellcheck"
    ln -f -s "${BREW_INSTALL_FOLDER}/bin/shellcheck" '/usr/local/bin/shellcheck'
    displayVersion "$(shellcheck -V)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../../brew/attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING SHELL-CHECK'

    # Install

    install
}

main "${@}"