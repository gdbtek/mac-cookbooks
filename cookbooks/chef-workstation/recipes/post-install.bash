#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    sudo rm -f -r '/Applications/Chef Workstation App.app' "$(getCurrentUserHomeFolder)/Library/LaunchAgents/io.chef.chef-workstation.app.plist"
}

main "${@}"