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

    if [[ "$(existCommand 'chef')" = 'true' ]]
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
    checkRequireNonRootUser

    header 'INSTALLING CHEF-CLIENT'

    # Install

    installDependencies
    install
}

main "${@}"