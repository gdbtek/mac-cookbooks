#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    local -r OLD_IFS="${IFS}"
    IFS=$'\n'

    local -r appNameList=($(
        ls -1 -d /Applications/*.app |
        cut -d '/' -f 3
    ))

    IFS="${OLD_IFS}"

    closeMacApplications 'CLOSING APPLICATIONS' "${appNameList[@]}"
}

main "${@}"