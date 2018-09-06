#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Non-Brew Applications

    "${appFolderPath}/../../../cookbooks/aws-cli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/dialog/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/go-lang/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/google-cloud-sdk/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/node-js/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/parallel/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/terraform/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/test-ssl/recipes/install.bash"

    # Brew Application

    "${appFolderPath}/../../../cookbooks/brew/recipes/uninstall.bash"

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/azure-cli/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/shell-check/recipes/install.bash"
}

main "${@}"