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

    sudo rm -f -r '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk

    if [[ "$(existCommand 'java')" = 'true' ]]
    then
        brew cask reinstall 'java'
    else
        brew cask install 'java'
    fi

    displayVersion "$(java --version)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING JDK'

    # Install

    installDependencies
    install
}

main "${@}"