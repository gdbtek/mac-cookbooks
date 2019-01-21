#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    rm -f -r '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk
    info "$(ls -1 -l '/Library/Java/JavaVirtualMachines')"
}

main "${@}"