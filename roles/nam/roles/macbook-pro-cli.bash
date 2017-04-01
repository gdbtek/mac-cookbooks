#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    "${appFolderPath}/../../../cookbooks/aws-cli/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/brew/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/consul/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/dialog/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/go-lang/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/maven/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/node-js/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/nomad/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/parallel/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/phantom-js/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/porter/recipes/install.bash"
    # "${appFolderPath}/../../../cookbooks/shell-check/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/siege/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/terraform/recipes/install.bash"
    "${appFolderPath}/../../../cookbooks/vault/recipes/install.bash"
}

main "${@}"