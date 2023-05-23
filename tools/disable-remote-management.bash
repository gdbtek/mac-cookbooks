#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireRootUser

    # Disable Remote Management

    header 'DISABLING REMOTE MANAGEMENT'
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop
}

main "${@}"