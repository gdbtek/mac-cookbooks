#!/bin/bash -e

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "${APP_FOLDER_PATH}/../../brew/recipes/install.bash" 'true'
    fi
}

function install()
{
    initializeFolder "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    if [[ -d '/usr/local/opt/coreutils' ]]
    then
        brew reinstall 'coreutils'
    else
        brew install 'coreutils'
    fi

    displayVersion "$(brew list --versions 'coreutils')"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING CORE-UTILS'

    # Install

    installDependencies
    install
}

main "${@}"