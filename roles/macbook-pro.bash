#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    "${appFolderPath}/../cookbooks/brew/recipes/install.bash"
    "${appFolderPath}/../cookbooks/go-lang/recipes/install.bash"
    "${appFolderPath}/../cookbooks/jq/recipes/install.bash"
    "${appFolderPath}/../cookbooks/packer/recipes/install.bash"
    "${appFolderPath}/../cookbooks/shell-check/recipes/install.bash"
}

main "${@}"