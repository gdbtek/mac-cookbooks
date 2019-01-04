#!/bin/bash -e

function uninstall()
{
    if [[ "$(existCommand 'brew')" = 'true' ]]
    then
        brew cask uninstall 'chef/chef/chefdk' || true
    fi
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING CHEF-CLIENT'

    # Uninstall

    uninstall
}

main "${@}"