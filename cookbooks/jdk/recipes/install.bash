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

    sudo rm -f -r '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk

    if [[ "$(existCommand 'java')" = 'true' ]]
    then
        brew cask reinstall "${JDK_VERSION}"
    else
        brew cask install "${JDK_VERSION}"
    fi

    displayVersion "$(java --version)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem

    header 'INSTALLING JDK'

    # Install

    installDependencies
    install
}

main "${@}"