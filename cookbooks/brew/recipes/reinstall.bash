#!/bin/bash -e

function main()
{
    local -r confirm="${1}"

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    sudo "$(dirname "${BASH_SOURCE[0]}")/uninstall.bash" "${confirm}"
    "$(dirname "${BASH_SOURCE[0]}")/install.bash" "${confirm}"
}

main "${@}"