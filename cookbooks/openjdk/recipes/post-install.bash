#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    # Mac M1

    local openJDKHomeFolderPath='/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home'

    # Mac Intel

    if [[ ! -d "${openJDKHomeFolderPath}" ]]
    then
        openJDKHomeFolderPath='/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home'
    fi

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