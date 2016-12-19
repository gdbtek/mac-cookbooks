#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${RUBY_INSTALL_FOLDER}"

    # Install

    local -r tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${RUBY_DOWNLOAD_URL}" "${tempFolder}"
    cd "${tempFolder}"
    "${tempFolder}/configure" --prefix="${RUBY_INSTALL_FOLDER}"
    make
    make install
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${RUBY_INSTALL_FOLDER}"
    symlinkLocalBin "${RUBY_INSTALL_FOLDER}/bin"
    rm -f -r "${tempFolder}"

    # Display Version

    displayVersion "$(ruby --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING RUBY'

    # Install

    install
}

main "${@}"