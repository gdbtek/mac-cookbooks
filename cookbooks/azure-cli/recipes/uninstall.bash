#!/bin/bash -e

function uninstall()
{
    if [[ "$(existCommand 'brew')" = 'true' ]]
    then
        brew uninstall 'azure-cli' || true
    fi
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'UNINSTALLING AZURE-CLI'

    # Uninstall

    uninstall
}

main "${@}"