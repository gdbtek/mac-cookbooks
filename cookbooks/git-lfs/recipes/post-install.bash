#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    git lfs install
    info "$(cat "$(getCurrentUserHomeFolder)/.gitconfig")"
}

main "${@}"