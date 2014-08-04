#!/bin/bash -e

function install()
{
    # Clean Up

    rm -rf "${binaryInstallFolder}" "${sourceInstallFolder}"
    mkdir -p "${binaryInstallFolder}" "${sourceInstallFolder}"

    # Install

    local latestVersionNumber="$(getLatestVersionNumber)"

    unzipRemoteFile "http://nodejs.org/dist/latest/node-v${latestVersionNumber}-darwin-x64.tar.gz" "${binaryInstallFolder}"
    unzipRemoteFile "http://nodejs.org/dist/latest/node-v${latestVersionNumber}.tar.gz" "${sourceInstallFolder}"
}

function getLatestVersionNumber()
{
    local versionPattern='[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:digit:]]{1,3}'
    local shaSum256="$(getRemoteFileContent 'http://nodejs.org/dist/latest/SHASUMS256.txt.asc')"

    echo "${shaSum256}" | grep -Eo "node-v${versionPattern}\.tar\.gz" | grep -Eo "${versionPattern}"
}

function main()
{
    local appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING NODE-JS'

    install
}

main "${@}"