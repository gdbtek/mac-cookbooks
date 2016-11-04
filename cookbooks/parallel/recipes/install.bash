#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PARALLEL_INSTALL_FOLDER}"

    # Install

    local -r tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${PARALLEL_DOWNLOAD_URL}" "${tempFolder}"
    cd "${tempFolder}"
    "${tempFolder}/configure" --prefix="${PARALLEL_INSTALL_FOLDER}"
    make
    make install
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PARALLEL_INSTALL_FOLDER}"
    ln -f -s "${PARALLEL_INSTALL_FOLDER}/bin/parallel" '/usr/local/bin/parallel'
    rm -f -r "${tempFolder}"

    # Display Version

    displayVersion "$(parallel --version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING PARALLEL'

    # Install

    install
    installCleanUp
}

main "${@}"