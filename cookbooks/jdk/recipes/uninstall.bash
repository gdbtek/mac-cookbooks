#!/bin/bash -e

function uninstall()
{
    if [[ "$(existCommand 'brew')" = 'true' ]]
    then
        brew cask uninstall "${JDK_VERSION}" || true
        sudo rm -f -r /Library/Java/JavaVirtualMachines/openjdk-*.jdk
    fi
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem

    header 'UNINSTALLING JDK'

    # Uninstall

    uninstall
}

main "${@}"