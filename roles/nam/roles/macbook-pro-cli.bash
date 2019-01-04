#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    # Brew

    "${appFolderPath}/../../../cookbooks/brew/recipes/uninstall.bash" 'true'
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/brew/recipes/install.bash"

    # Brew Application

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/chef-client/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/core-utils/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/jdk/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/shell-check/recipes/install.bash"

    # Non-Brew Applications

    "${appFolderPath}/../../../cookbooks/aws-cli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/dialog/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/go-lang/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/node-js/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/parallel/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/terraform/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/test-ssl/recipes/install.bash"

    # Finish

    postUpMessage
}

main "${@}"