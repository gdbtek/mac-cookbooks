#!/bin/bash -e

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Load Libraries

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireNonRootUser

    # Brew

    "${appFolderPath}/../../../cookbooks/brew/recipes/reinstall.bash" 'true'

    # Packages

    local -r caskPackageNames=(
        'chef/chef/chefdk'
        'java'
    )

    local -r packageNames=(
        'ack'
        'awscli'
        'azure-cli'
        'ccat'
        'coreutils'
        'cowsay'
        'dialog'
        'geoip'
        'glances'
        'go'
        'google-cloud-sdk'
        'hping'
        'htop'
        'jq'
        'mas'
        'moreutils'
        'mtr'
        'netcat'
        'nmap'
        'node'
        'nomad'
        'packer'
        'shellcheck'
        'siege'
        'terraform'
        'testssl'
        'tmux'
        'tree'
        'vagrant'
        'vault'
        'wget'
    )

    "${appFolderPath}/../../../tools/install-brew-applications.bash" \
        --cask-package-names "${caskPackageNames[@]}" \
        --package-names "${packageNames[@]}"

    # Finish

    postUpMessage
}

main "${@}"