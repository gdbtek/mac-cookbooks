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
    initializeFolder "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    if [[ "$(existCommand 'java')" = 'true' ]]
    then
        brew cask reinstall 'chef/chef/chefdk'
    else
        brew cask install 'chef/chef/chefdk'
    fi

    displayVersion "$(knife --version)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem

    header 'INSTALLING CHEF-CLIENT'

    # Install

    installDependencies
    install
}

main "${@}"