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

    if [[ "$(existCommand 'az')" = 'true' ]]
    then
        brew reinstall 'azure-cli'
    else
        brew install 'azure-cli'
    fi

    displayVersion "$(az --version)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING AZURE-CLI'

    # Install

    installDependencies
    install
}

main "${@}"