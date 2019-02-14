#!/bin/bash -e

function main()
{
    "$(dirname "${BASH_SOURCE[0]}")/mac-cli-apps.bash"
    "$(dirname "${BASH_SOURCE[0]}")/mac-cask-apps.bash"
    "$(dirname "${BASH_SOURCE[0]}")/mac-store-apps.bash"
}

main "${@}"