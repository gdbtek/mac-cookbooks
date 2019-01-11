#!/bin/bash -e

function uninstall()
{
    if [[ "$(existCommand 'brew')" = 'true' ]]
    then
        brew uninstall 'geoip' || true
    fi
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING GEO-IP'

    # Uninstall

    uninstall
}

main "${@}"