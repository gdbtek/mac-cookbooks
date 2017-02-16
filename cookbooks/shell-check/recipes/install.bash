#!/bin/bash -e

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "${APP_FOLDER_PATH}/../../brew/recipes/install.bash"
    fi
}

function install()
{
    initializeFolder "$(getUserHomeFolder "${SUDO_USER}")/Library/Caches/Homebrew"

    su -l "${SUDO_USER}" -c "${SHELL_CHECK_BREW_INSTALL_FOLDER_PATH}/bin/brew install shellcheck"

    if [[ "${SHELL_CHECK_BREW_INSTALL_FOLDER_PATH}" != '/usr/local' ]]
    then
        ln -f -s "${SHELL_CHECK_BREW_INSTALL_FOLDER_PATH}/bin/shellcheck" '/usr/local/bin/shellcheck'
    fi

    displayVersion "$(shellcheck -V)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING SHELL-CHECK'

    # Install

    installDependencies
    install
}

main "${@}"