#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireNonRootUser

    # Brew

    "${appFolderPath}/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Brew Applications

    "${appFolderPath}/../../../cookbooks/ack/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/awscli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/azure-cli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/ccat/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/coreutils/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/cowsay/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/dialog/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/geoip/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/glances/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/go/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/hping/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/htop/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/mas/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/moreutils/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/mtr/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/netcat/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/nmap/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/node/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/shellcheck/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/terraform/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/testssl/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/tmux/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/tree/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/wget/recipes/install.bash"

    # Brew Cask Applications

    "${appFolderPath}/../../../cookbooks/chefdk/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/java/recipes/install.bash"

    # Finish

    postUpMessage
}

main "${@}"