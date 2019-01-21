#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    checkExistFolder "$(ls -1 -d -t '/Library/Java/JavaVirtualMachines/'openjdk-*.jdk | head -1)/Contents/Home"

    local -r javaHomeConfig="export JAVA_HOME=\"\$(ls -1 -d -t '/Library/Java/JavaVirtualMachines/'openjdk-*.jdk | head -1)/Contents/Home\""

    appendToFileIfNotFound '/etc/profile' "${javaHomeConfig}" "${javaHomeConfig}" 'false' 'false' 'true'
    info "$(grep -F "${javaHomeConfig}" '/etc/profile')"
}

main "${@}"