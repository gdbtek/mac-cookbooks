#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    local -r openJDKFolderPath="$(ls -1 -d -t '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk | head -1)"

    checkExistFolder "${openJDKFolderPath}"

    local -r javaHomeConfig='export JAVA_HOME="$(ls -1 -d -t '/Library/Java/JavaVirtualMachines'/openjdk-*.jdk | head -1)"'

    appendToFileIfNotFound '/etc/profile' "$(stringToSearchPattern "${javaHomeConfig}")" "${javaHomeConfig}" 'false' 'false' 'true'
}

main "${@}"