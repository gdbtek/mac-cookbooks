#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${TERRAFORM_INSTALL_FOLDER}"
    initializeFolder "${TERRAFORM_INSTALL_FOLDER}/bin"

    # Install

    unzipRemoteFile "${TERRAFORM_DOWNLOAD_URL}" "${TERRAFORM_INSTALL_FOLDER}/bin"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${TERRAFORM_INSTALL_FOLDER}"
    ln -f -s "${TERRAFORM_INSTALL_FOLDER}/bin/terraform" '/usr/local/bin/terraform'

    # Display Version

    displayVersion "$("${TERRAFORM_INSTALL_FOLDER}/bin/terraform" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING TERRAFORM'

    install
}

main "${@}"