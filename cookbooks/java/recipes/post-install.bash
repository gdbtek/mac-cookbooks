#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    local -r openJDKHomeFolderPath='/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home'

    checkExistFolder "${openJDKHomeFolderPath}"

    local -r javaHomeConfig="export JAVA_HOME='${openJDKHomeFolderPath}'"

    appendToFileIfNotFound \
        '/etc/profile' \
        "${javaHomeConfig}" \
        "${javaHomeConfig}" \
        'false' \
        'false' \
        'true'

    info "$(grep -F "${javaHomeConfig}" '/etc/profile')"
}

main "${@}"