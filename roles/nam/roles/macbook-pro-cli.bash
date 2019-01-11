#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireRootUser

    # Brew

    "${appFolderPath}/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Brew Cask Applications

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/chef-client/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/jdk/recipes/install.bash"

    # Brew CLI Applications

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/core-utils/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/cowsay/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/geo-ip/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/htop/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/nmap/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/shell-check/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/tree/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/wget/recipes/install.bash"

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