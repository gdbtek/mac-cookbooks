#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    closeMacApplications '' 'Chef Workstation App'
    sudo sudo rm -f -r '/Applications/Chef Workstation App.app'
}

main "${@}"