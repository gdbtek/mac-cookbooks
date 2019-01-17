#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireRootUser

    # Brew

    "${appFolderPath}/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Non-Brew Applications

    "${appFolderPath}/../../../cookbooks/aws-cli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/go-lang/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/node-js/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/terraform/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/test-ssl/recipes/install.bash"

    # Brew Applications

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/ack/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/azure-cli/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/ccat/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/coreutils/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/cowsay/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/dialog/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/geoip/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/glances/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/hping/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/htop/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/mas/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/moreutils/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/mtr/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/netcat/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/nmap/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/shellcheck/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/tmux/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/tree/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/wget/recipes/install.bash"

    # Brew Cask Applications

    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/chefdk/recipes/install.bash"
    sudo -u "${SUDO_USER}" "${appFolderPath}/../../../cookbooks/java/recipes/install.bash"

    # Finish

    postUpMessage
}

main "${@}"