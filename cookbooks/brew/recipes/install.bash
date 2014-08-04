#!/bin/bash -e

function install()
{
    # Clean Up

    rm -rf "${brewInstallFolder}"
    mkdir -p "${brewInstallFolder}"

    # Install

    unzipRemoteFile "${brewDownloadURL}" "${brewInstallFolder}" 'tar.gz'

    "${brewInstallFolder}/bin/brew" doctor
    "${brewInstallFolder}/bin/brew" update

    info "\n$(aws --version 2>&1)"
}

function main()
{
    local appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING BREW'

    install
}

main "${@}"