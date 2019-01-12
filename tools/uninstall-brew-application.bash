#!/bin/bash -e

function uninstall()
{
    local -r applicationName="${1}"

    if [[ "$(existCommand 'brew')" = 'true' ]]
    then
        brew uninstall "${applicationName}" || true
    fi
}

function main()
{
    local -r applicationName="${1}"

    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser
    checkNonEmptyString "${applicationName}" 'undefined application name'

    header "UNINSTALLING $(tr '[:lower:]' '[:upper:]' <<< "${applicationName}")"

    # Uninstall

    uninstall "${applicationName}"
}

main "${@}"