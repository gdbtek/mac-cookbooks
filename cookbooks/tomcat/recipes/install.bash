#!/bin/bash

function install()
{
    # Clean Up

    rm -rf "${installFolder}"
    mkdir -p "${installFolder}"

    # Install

    unzipRemoteFile "${downloadURL}" "${installFolder}"

    # Config Server

    local serverConfigData=(
        8009 "${ajpPort}"
        8005 "${commandPort}"
        8080 "${httpPort}"
        8443 "${httpsPort}"
    )

    createFileFromTemplate "${installFolder}/conf/server.xml" "${installFolder}/conf/server.xml" "${serverConfigData[@]}"
}

function main()
{
    local appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING TOMCAT'

    install
}

main "${@}"
