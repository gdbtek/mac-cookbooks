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

    brew install shellcheck

    displayVersion "$(shellcheck -V)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING SHELL-CHECK'

    # Install

    installDependencies
    install
}

main "${@}"